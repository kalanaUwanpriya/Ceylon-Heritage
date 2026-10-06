import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedPlacesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ============================================================
  // GET CURRENT USER ID
  // ============================================================

  String? get _currentUserId {
    return _auth.currentUser?.uid;
  }

  // ============================================================
  // SAVE PLACE
  // ============================================================

  Future<void> savePlace(String placeId) async {
    final userId = _currentUserId;

    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    if (placeId.trim().isEmpty) {
      throw Exception('Place ID cannot be empty.');
    }

    final documentId = '${userId}_$placeId';

    await _firestore.collection('saved_places').doc(documentId).set({
      'userId': userId,
      'placeId': placeId.trim(),
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  // ============================================================
  // REMOVE SAVED PLACE
  // ============================================================

  Future<void> removeSavedPlace(String placeId) async {
    final userId = _currentUserId;

    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    final documentId = '${userId}_$placeId';

    await _firestore.collection('saved_places').doc(documentId).delete();
  }

  // ============================================================
  // CHECK WHETHER PLACE IS SAVED
  // ============================================================

  Future<bool> isPlaceSaved(String placeId) async {
    final userId = _currentUserId;

    if (userId == null) {
      return false;
    }

    final documentId = '${userId}_$placeId';

    final snapshot = await _firestore
        .collection('saved_places')
        .doc(documentId)
        .get();

    return snapshot.exists;
  }

  // ============================================================
  // GET ALL SAVED PLACE RECORDS
  // ============================================================

  Future<List<String>> getSavedPlaceIds() async {
    final userId = _currentUserId;

    if (userId == null) {
      return [];
    }

    final snapshot = await _firestore
        .collection('saved_places')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) {
          final data = doc.data();

          final placeId = data['placeId'];

          return placeId is String ? placeId : '';
        })
        .where((placeId) => placeId.isNotEmpty)
        .toList();
  }

  // ============================================================
  // STREAM SAVED PLACE RECORDS
  // ============================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> watchSavedPlaces() {
    final userId = _currentUserId;

    if (userId == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('saved_places')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
