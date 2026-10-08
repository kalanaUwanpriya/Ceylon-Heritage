import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a user profile in Firestore
  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
    String phone = '',
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'profilePhoto': '',
      'bio': '',
      'accountStatus': 'active',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get a user's profile
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(
    String uid,
  ) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  // Update a user's profile
  Future<void> updateUserProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection('users').doc(uid).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete a user's Firestore profile
  Future<void> deleteUserProfile(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  // Delete personal Firestore data belonging to this user.
  Future<void> deleteAllUserData(String uid) async {
    final collections = [
      'saved_places',
      'visited_history',
      'reviews',
      'saved_routes',
      'user_route_plans',
      'service_suggestions',
    ];

    // Delete documents owned by the user.
    for (final collectionName in collections) {
      while (true) {
        final snapshot = await _firestore
            .collection(collectionName)
            .where('userId', isEqualTo: uid)
            .limit(100)
            .get();

        if (snapshot.docs.isEmpty) break;

        final batch = _firestore.batch();

        for (final doc in snapshot.docs) {
          batch.delete(doc.reference);
        }

        await batch.commit();
      }
    }

    // Delete notification preferences.
    await _firestore.collection('notification_preferences').doc(uid).delete();

    // Delete user profile last.
    await deleteUserProfile(uid);
  }
}
