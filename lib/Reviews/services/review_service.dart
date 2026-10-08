import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/review.dart';

class PlaceReviewStats {
  final int count;
  final double average;

  const PlaceReviewStats({
    required this.count,
    required this.average,
  });

  String get formattedAverage => average.toStringAsFixed(1);
  String get formattedCount =>
      '$count ${count == 1 ? "review" : "reviews"}';
}

class ReviewService {
  final FirebaseFirestore? _customFirestore;
  final FirebaseAuth? _customAuth;

  ReviewService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _customFirestore = firestore,
        _customAuth = auth;

  FirebaseFirestore get _firestore =>
      _customFirestore ?? FirebaseFirestore.instance;

  FirebaseAuth get _auth => _customAuth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _reviewsRef =>
      _firestore.collection('reviews');

  String? get currentUserId => _auth.currentUser?.uid;

  String generateReviewId(String userId, String placeId) =>
      '${userId}_$placeId';

  // ============================================================
  // CREATE OR SET REVIEW
  // ============================================================
  Future<Review> createReview({
    required String placeId,
    required String placeName,
    required String placeImage,
    required String location,
    required int rating,
    String? userId,
  }) async {
    final uid = userId ?? currentUserId;
    if (uid == null) {
      throw Exception('User must be logged in to submit a review.');
    }

    final safeRating = rating.clamp(1, 3);
    final reviewId = generateReviewId(uid, placeId);
    final docRef = _reviewsRef.doc(reviewId);
    final existingDoc = await docRef.get();

    if (existingDoc.exists) {
      // User already reviewed this place; update existing document
      await docRef.update({
        'rating': safeRating,
        'placeName': placeName,
        'placeImage': placeImage,
        'location': location,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      final updatedSnap = await docRef.get();
      return Review.fromFirestore(updatedSnap);
    } else {
      // Create new review
      final data = {
        'userId': uid,
        'placeId': placeId,
        'placeName': placeName,
        'placeImage': placeImage,
        'location': location,
        'rating': safeRating,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await docRef.set(data);
      final newSnap = await docRef.get();
      return Review.fromFirestore(newSnap);
    }
  }

  // ============================================================
  // UPDATE REVIEW
  // ============================================================
  Future<void> updateReview(String reviewId, int newRating) async {
    final safeRating = newRating.clamp(1, 3);
    await _reviewsRef.doc(reviewId).update({
      'rating': safeRating,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ============================================================
  // DELETE REVIEW
  // ============================================================
  Future<void> deleteReview(String reviewId) async {
    await _reviewsRef.doc(reviewId).delete();
  }

  // ============================================================
  // GET REVIEWS FOR A PLACE (REAL-TIME STREAM)
  // ============================================================
  Stream<List<Review>> getPlaceReviews(String placeId) {
    return _reviewsRef
        .where('placeId', isEqualTo: placeId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
    });
  }

  // ============================================================
  // GET PLACE REVIEW STATS (REAL-TIME STREAM)
  // ============================================================
  Stream<PlaceReviewStats> getPlaceReviewStats(String placeId) {
    return getPlaceReviews(placeId).map((reviews) {
      if (reviews.isEmpty) {
        return const PlaceReviewStats(count: 0, average: 0.0);
      }
      final sum = reviews.fold<int>(0, (prev, r) => prev + r.rating);
      final avg = sum / reviews.length;
      return PlaceReviewStats(count: reviews.length, average: avg);
    });
  }

  // ============================================================
  // GET CURRENT USER'S REVIEWS (REAL-TIME STREAM)
  // ============================================================
  Stream<List<Review>> getCurrentUserReviews() {
    final uid = currentUserId;
    if (uid == null) {
      return Stream.value(<Review>[]);
    }

    return _reviewsRef
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      final reviews =
          snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();

      // Sort newest first in-memory
      reviews.sort((a, b) {
        final aTime = a.updatedAt ??
            a.createdAt ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.updatedAt ??
            b.createdAt ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });

      return reviews;
    });
  }

  // ============================================================
  // GET USER REVIEW FOR A SPECIFIC PLACE
  // ============================================================
  Future<Review?> getUserReviewForPlace(
    String placeId, {
    String? userId,
  }) async {
    final uid = userId ?? currentUserId;
    if (uid == null) return null;

    final reviewId = generateReviewId(uid, placeId);
    final doc = await _reviewsRef.doc(reviewId).get();
    if (doc.exists && doc.data() != null) {
      return Review.fromFirestore(doc);
    }

    // Fallback query if id was stored differently
    final query = await _reviewsRef
        .where('userId', isEqualTo: uid)
        .where('placeId', isEqualTo: placeId)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return Review.fromFirestore(query.docs.first);
    }
    return null;
  }

  // ============================================================
  // STREAM USER REVIEW FOR A SPECIFIC PLACE
  // ============================================================
  Stream<Review?> watchUserReviewForPlace(
    String placeId, {
    String? userId,
  }) {
    final uid = userId ?? currentUserId;
    if (uid == null) {
      return Stream.value(null);
    }

    final reviewId = generateReviewId(uid, placeId);
    return _reviewsRef.doc(reviewId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return Review.fromFirestore(doc);
      }
      return null;
    });
  }

  // ============================================================
  // CHECK IF USER HAS REVIEWED A PLACE
  // ============================================================
  Future<bool> hasUserReviewedPlace(
    String placeId, {
    String? userId,
  }) async {
    final review = await getUserReviewForPlace(placeId, userId: userId);
    return review != null;
  }

  // ============================================================
  // CALCULATE AVERAGE RATING
  // ============================================================
  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 0.0;
    final sum = reviews.fold<int>(0, (prev, r) => prev + r.rating);
    return sum / reviews.length;
  }
}
