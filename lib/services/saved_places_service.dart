import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedPlaceModel {
  final String id;
  final String userId;
  final String destinationId;
  final String destinationName;
  final String destinationImage;
  final String location;
  final String description;
  final DateTime? savedAt;
  /// 'place' for individual saved places, 'tour' for complete walking tours, 'service' for individual services.
  final String type;
  /// JSON-encoded tour params (tempo, timeAvailable, ratingFilter, destinationName).
  /// Only present when type == 'tour'.
  final String? tourParams;
  /// Category / type of the service (e.g. 'Hotel', 'Accommodation', 'Food & Restaurants').
  final String? category;
  /// JSON-encoded service data to reconstruct ServicePlace.
  final String? serviceData;

  const SavedPlaceModel({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
    required this.location,
    required this.description,
    this.savedAt,
    this.type = 'place',
    this.tourParams,
    this.category,
    this.serviceData,
  });

  /// Returns true when this entry represents a complete walking tour.
  bool get isTour => type == 'tour';

  /// Returns true when this entry represents an individual service item.
  bool get isService =>
      type == 'service' || destinationId.startsWith('service_');

  /// Decodes the stored [tourParams] JSON. Returns null if not a tour or invalid.
  Map<String, dynamic>? get decodedTourParams {
    if (tourParams == null) return null;
    try {
      return jsonDecode(tourParams!) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Decodes the stored [serviceData] JSON. Returns null if not a service or invalid.
  Map<String, dynamic>? get decodedServiceData {
    if (serviceData == null) return null;
    try {
      return jsonDecode(serviceData!) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  factory SavedPlaceModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    DateTime? parsedDate;
    final ts = data['savedAt'] ?? data['createdAt'];
    if (ts is Timestamp) {
      parsedDate = ts.toDate();
    }
    return SavedPlaceModel(
      id: doc.id,
      userId: data['userId'] as String? ?? '',
      destinationId:
          data['destinationId'] as String? ??
          (data['placeId'] as String? ?? ''),
      destinationName: data['destinationName'] as String? ?? '',
      destinationImage: data['destinationImage'] as String? ?? '',
      location: data['location'] as String? ?? '',
      description: data['description'] as String? ?? '',
      savedAt: parsedDate,
      type: data['type'] as String? ?? 'place',
      tourParams: data['tourParams'] as String?,
      category: data['category'] as String?,
      serviceData: data['serviceData'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'destinationId': destinationId,
      'placeId': destinationId,
      'destinationName': destinationName,
      'destinationImage': destinationImage,
      'location': location,
      'description': description,
      'type': type,
      if (tourParams != null) 'tourParams': tourParams,
      if (category != null) 'category': category,
      if (serviceData != null) 'serviceData': serviceData,
      'createdAt': FieldValue.serverTimestamp(),
      'savedAt': FieldValue.serverTimestamp(),
    };
  }
}

class SavedPlacesService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SavedPlacesService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  bool get isAuthenticated => _auth.currentUser != null;

  static String normalizeId(String input) {
    return input
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  static String buildDocId(String userId, String destinationId) {
    return '${userId}_${normalizeId(destinationId)}';
  }

  // ============================================================
  // SAVE PLACE
  // ============================================================
  Future<void> savePlace({
    required String destinationId,
    required String destinationName,
    required String destinationImage,
    required String location,
    required String description,
  }) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    final normId = normalizeId(destinationId);
    if (normId.isEmpty) {
      throw Exception('Destination ID cannot be empty.');
    }

    final docId = buildDocId(userId, normId);
    await _firestore
        .collection('saved_places')
        .doc(docId)
        .set({
          'userId': userId,
          'destinationId': normId,
          'placeId': normId,
          'destinationName': destinationName.trim(),
          'destinationImage': destinationImage.trim(),
          'location': location.trim(),
          'description': description.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'savedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  // ============================================================
  // SAVE COMPLETE WALKING TOUR
  // ============================================================
  /// Saves a complete walking tour as a single record in [saved_places].
  ///
  /// [tourId]       - Deterministic ID for the tour (e.g. based on params).
  /// [tourTitle]    - Display headline of the generated tour.
  /// [tourImage]    - Image asset path to show in the Saved Places card.
  /// [location]     - Destination city / region label.
  /// [description]  - Summary text (e.g. "5 stops · 7h 45m · 12.6 km").
  /// [tourParams]   - Map with tempo, timeAvailable, ratingFilter, destinationName
  ///                  so the tour can be re-generated when the user opens it.
  Future<void> saveTour({
    required String tourId,
    required String tourTitle,
    required String tourImage,
    required String location,
    required String description,
    required Map<String, dynamic> tourParams,
  }) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('User is not logged in.');

    final normId = normalizeId(tourId);
    if (normId.isEmpty) throw Exception('Tour ID cannot be empty.');

    final docId = buildDocId(userId, normId);
    await _firestore.collection('saved_places').doc(docId).set({
      'userId': userId,
      'destinationId': normId,
      'placeId': normId,
      'destinationName': tourTitle.trim(),
      'destinationImage': tourImage.trim(),
      'location': location.trim(),
      'description': description.trim(),
      'type': 'tour',
      'tourParams': jsonEncode(tourParams),
      'createdAt': FieldValue.serverTimestamp(),
      'savedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ============================================================
  // SAVE INDIVIDUAL SERVICE
  // ============================================================
  /// Saves an individual service item as a single record in [saved_places].
  Future<void> saveService({
    required String serviceId,
    required String serviceName,
    required String serviceImage,
    required String location,
    required String description,
    required String category,
    Map<String, dynamic>? serviceData,
  }) async {
    final userId = currentUserId;
    if (userId == null) throw Exception('User is not logged in.');

    final normId = normalizeId(serviceId);
    if (normId.isEmpty) throw Exception('Service ID cannot be empty.');

    final docId = buildDocId(userId, normId);
    await _firestore.collection('saved_places').doc(docId).set({
      'userId': userId,
      'destinationId': normId,
      'placeId': normId,
      'destinationName': serviceName.trim(),
      'destinationImage': serviceImage.trim(),
      'location': location.trim(),
      'description': description.trim(),
      'type': 'service',
      'category': category.trim(),
      if (serviceData != null) 'serviceData': jsonEncode(serviceData),
      'createdAt': FieldValue.serverTimestamp(),
      'savedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ============================================================
  // REMOVE SAVED PLACE
  // ============================================================
  Future<void> removeSavedPlace(String destinationId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    final normId = normalizeId(destinationId);
    if (normId.isEmpty) {
      return;
    }

    final docId = buildDocId(userId, normId);
    await _firestore.collection('saved_places').doc(docId).delete();
  }

  // ============================================================
  // CHECK WHETHER PLACE IS SAVED
  // ============================================================
  Future<bool> isPlaceSaved(String destinationId) async {
    final userId = currentUserId;
    if (userId == null) {
      return false;
    }

    final normId = normalizeId(destinationId);
    final docId = buildDocId(userId, normId);
    final snapshot =
        await _firestore.collection('saved_places').doc(docId).get();
    return snapshot.exists;
  }

  // ============================================================
  // WATCH SINGLE PLACE SAVED STATUS (REAL-TIME)
  // ============================================================
  Stream<bool> watchIsPlaceSaved(String destinationId) async* {
    await for (final user in _auth.authStateChanges()) {
      if (user == null) {
        yield false;
      } else {
        final normId = normalizeId(destinationId);
        final docId = buildDocId(user.uid, normId);
        yield* _firestore
            .collection('saved_places')
            .doc(docId)
            .snapshots()
            .map((snapshot) => snapshot.exists);
      }
    }
  }

  // ============================================================
  // WATCH ALL SAVED PLACES FOR CURRENT USER (REAL-TIME)
  // ============================================================
  Stream<List<SavedPlaceModel>> watchSavedPlaces() async* {
    await for (final user in _auth.authStateChanges()) {
      if (user == null) {
        yield [];
      } else {
        yield* _firestore
            .collection('saved_places')
            .where('userId', isEqualTo: user.uid)
            .snapshots()
            .map((snapshot) {
              final places =
                  snapshot.docs
                      .map((doc) => SavedPlaceModel.fromFirestore(doc))
                      .toList();

              // In-memory sort by savedAt descending (avoids requiring composite indexes)
              places.sort((a, b) {
                final aDate =
                    a.savedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                final bDate =
                    b.savedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                return bDate.compareTo(aDate);
              });
              return places;
            });
      }
    }
  }

  // ============================================================
  // GET ALL SAVED PLACE IDS (BACKWARDS COMPATIBILITY)
  // ============================================================
  Future<List<String>> getSavedPlaceIds() async {
    final userId = currentUserId;
    if (userId == null) {
      return [];
    }

    final snapshot =
        await _firestore
            .collection('saved_places')
            .where('userId', isEqualTo: userId)
            .get();

    return snapshot.docs
        .map((doc) {
          final data = doc.data();
          final destinationId = data['destinationId'] ?? data['placeId'];
          return destinationId is String ? destinationId : '';
        })
        .where((id) => id.isNotEmpty)
        .toList();
  }
}
