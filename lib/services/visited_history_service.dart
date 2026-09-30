import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VisitedHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId {
    return _auth.currentUser?.uid;
  }

  // ============================================================
  // ADD VISITED PLACE
  // ============================================================

  Future<void> addVisitedPlace({
    required String placeId,
    String? routeId,
  }) async {
    final userId = _currentUserId;

    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    if (placeId.trim().isEmpty) {
      throw Exception('Place ID cannot be empty.');
    }

    await _firestore.collection('visited_history').add({
      'userId': userId,
      'placeId': placeId.trim(),
      'visitedAt': FieldValue.serverTimestamp(),
      'routeId': routeId?.trim() ?? '',
    });
  }

  // ============================================================
  // GET VISITED HISTORY
  // ============================================================

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getVisitedHistory() async {
    final userId = _currentUserId;

    if (userId == null) {
      return [];
    }

    // Get only the current user's visited history.
    // We do not use orderBy() here because that can require
    // an additional Firestore composite index.

    final snapshot = await _firestore
        .collection('visited_history')
        .where('userId', isEqualTo: userId)
        .get();

    final documents = snapshot.docs;

    // Sort the records in Flutter instead of Firestore.
    // Newest visited places appear first.
    documents.sort((a, b) {
      final aTimestamp = a.data()['visitedAt'];
      final bTimestamp = b.data()['visitedAt'];

      if (aTimestamp is Timestamp && bTimestamp is Timestamp) {
        return bTimestamp.compareTo(aTimestamp);
      }

      return 0;
    });

    return documents;
  }

  // ============================================================
  // CHECK WHETHER PLACE WAS VISITED
  // ============================================================

  Future<bool> isPlaceVisited(String placeId) async {
    final userId = _currentUserId;

    if (userId == null) {
      return false;
    }

    final snapshot = await _firestore
        .collection('visited_history')
        .where('userId', isEqualTo: userId)
        .where('placeId', isEqualTo: placeId.trim())
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  // ============================================================
  // REMOVE VISITED HISTORY
  // ============================================================

  Future<void> removeVisitedHistory(String documentId) async {
    final userId = _currentUserId;

    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    final document = await _firestore
        .collection('visited_history')
        .doc(documentId)
        .get();

    if (!document.exists) {
      return;
    }

    final data = document.data();

    if (data?['userId'] != userId) {
      throw Exception('You cannot delete another user\'s history.');
    }

    await _firestore.collection('visited_history').doc(documentId).delete();
  }
}
