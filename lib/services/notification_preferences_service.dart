import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationPreferencesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId {
    return _auth.currentUser?.uid;
  }

  // ============================================================
  // GET CURRENT USER ID
  // ============================================================

  String _requireUserId() {
    final userId = _currentUserId;

    if (userId == null) {
      throw Exception('User is not logged in.');
    }

    return userId;
  }

  // ============================================================
  // GET NOTIFICATION PREFERENCES
  // ============================================================

  Future<Map<String, dynamic>> getPreferences() async {
    final userId = _requireUserId();

    final document = await _firestore
        .collection('notification_preferences')
        .doc(userId)
        .get();

    if (!document.exists || document.data() == null) {
      return _defaultPreferences(userId);
    }

    return document.data()!;
  }

  // ============================================================
  // SAVE NOTIFICATION PREFERENCES
  // ============================================================

  Future<void> savePreferences({
    required bool generalUpdates,
    required bool routeRecommendations,
    required bool savedPlaces,
    required bool eventsActivities,
    required bool offersPromotions,
    required bool travelTips,
    required bool securityAlerts,
  }) async {
    final userId = _requireUserId();

    await _firestore.collection('notification_preferences').doc(userId).set({
      'userId': userId,
      'generalUpdates': generalUpdates,
      'routeRecommendations': routeRecommendations,
      'savedPlaces': savedPlaces,
      'eventsActivities': eventsActivities,
      'offersPromotions': offersPromotions,
      'travelTips': travelTips,
      'securityAlerts': securityAlerts,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ============================================================
  // DEFAULT PREFERENCES
  // ============================================================

  Map<String, dynamic> _defaultPreferences(String userId) {
    return {
      'userId': userId,
      'generalUpdates': true,
      'routeRecommendations': true,
      'savedPlaces': true,
      'eventsActivities': true,
      'offersPromotions': false,
      'travelTips': true,
      'securityAlerts': true,
    };
  }
}
