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

  // ============================================================
  // GET REVIEWS FOR A PLACE ONCE (FUTURE)
  // ============================================================
  Future<List<Review>> getPlaceReviewsOnce(String placeId) async {
    try {
      final query =
          await _reviewsRef.where('placeId', isEqualTo: placeId).get();
      return query.docs.map((doc) => Review.fromFirestore(doc)).toList();
    } catch (_) {
      return [];
    }
  }

  // ============================================================
  // GET REAL DATABASE AVERAGE RATING FOR A PLACE
  // ============================================================
  Future<PlaceReviewStats> getRealPlaceStats(String placeId) async {
    var reviews = await getPlaceReviewsOnce(placeId);

    if (reviews.isEmpty) {
      final normalized =
          placeId.toLowerCase().trim().replaceAll('-', '_');
      if (normalized != placeId) {
        reviews = await getPlaceReviewsOnce(normalized);
      }
      if (reviews.isEmpty) {
        if (normalized == 'lankathilaka_image_house') {
          reviews = await getPlaceReviewsOnce('lankathilaka');
        } else if (normalized == 'lankathilaka') {
          reviews = await getPlaceReviewsOnce('lankathilaka_image_house');
        } else if (normalized == 'dambulla_cave_temple') {
          reviews = await getPlaceReviewsOnce('dambulla');
        } else if (normalized == 'dambulla') {
          reviews = await getPlaceReviewsOnce('dambulla_cave_temple');
        } else if (normalized == 'sigiriya_rock_fortress') {
          reviews = await getPlaceReviewsOnce('sigiriya');
        } else if (normalized == 'sigiriya') {
          reviews = await getPlaceReviewsOnce('sigiriya_rock_fortress');
        } else if (normalized == 'ibbankatuwa_megalithic_tombs') {
          reviews = await getPlaceReviewsOnce('ibbankatuwa');
        } else if (normalized == 'ibbankatuwa') {
          reviews = await getPlaceReviewsOnce('ibbankatuwa_megalithic_tombs');
        } else if (normalized == 'galle_dutch_fort_lighthouse') {
          reviews = await getPlaceReviewsOnce('galle_fort');
          if (reviews.isEmpty) reviews = await getPlaceReviewsOnce('galle');
        } else if (normalized == 'galle_fort' || normalized == 'galle') {
          reviews = await getPlaceReviewsOnce('galle_dutch_fort_lighthouse');
        } else if (normalized == 'star_fort_matara') {
          reviews = await getPlaceReviewsOnce('star_fort');
        } else if (normalized == 'star_fort') {
          reviews = await getPlaceReviewsOnce('star_fort_matara');
        } else if (normalized == 'mulkirigala_rock_temple') {
          reviews = await getPlaceReviewsOnce('mulkirigala');
        } else if (normalized == 'mulkirigala') {
          reviews = await getPlaceReviewsOnce('mulkirigala_rock_temple');
        } else if (normalized == 'kushta_raja_gala') {
          reviews = await getPlaceReviewsOnce('kushta_raja');
        } else if (normalized == 'kushta_raja') {
          reviews = await getPlaceReviewsOnce('kushta_raja_gala');
        }
      }
      if (reviews.isEmpty) {
        if (placeId.endsWith('a')) {
          reviews = await getPlaceReviewsOnce(
              placeId.substring(0, placeId.length - 1));
        } else {
          reviews = await getPlaceReviewsOnce('${placeId}a');
        }
      }
    }

    if (reviews.isEmpty) {
      return const PlaceReviewStats(count: 0, average: 0.0);
    }

    final sum = reviews.fold<int>(0, (prev, r) => prev + r.rating);
    final avg = sum / reviews.length;
    return PlaceReviewStats(count: reviews.length, average: avg);
  }

  // ============================================================
  // GET REAL DATABASE STATS FOR MULTIPLE PLACES (BATCH)
  // ============================================================
  Future<Map<String, PlaceReviewStats>> getBatchRealPlaceStats(
      List<String> placeIds) async {
    final Map<String, PlaceReviewStats> results = {};
    try {
      final allSnap = await _reviewsRef.get();
      final Map<String, List<int>> ratingsMap = {};
      for (final doc in allSnap.docs) {
        final data = doc.data();
        final pId = (data['placeId'] as String? ?? '')
            .toLowerCase()
            .trim()
            .replaceAll('-', '_');
        final r = (data['rating'] as num?)?.toInt();
        if (pId.isNotEmpty && r != null && r > 0) {
          ratingsMap.putIfAbsent(pId, () => []).add(r.clamp(1, 3));
        }
      }

      for (final id in placeIds) {
        final normalized =
            id.toLowerCase().trim().replaceAll('-', '_');
        List<int>? ratings = ratingsMap[normalized];
        if (ratings == null || ratings.isEmpty) {
          if (normalized == 'lankathilaka_image_house') {
            ratings = ratingsMap['lankathilaka'];
          } else if (normalized == 'lankathilaka') {
            ratings = ratingsMap['lankathilaka_image_house'];
          } else if (normalized == 'dambulla_cave_temple') {
            ratings = ratingsMap['dambulla'];
          } else if (normalized == 'dambulla') {
            ratings = ratingsMap['dambulla_cave_temple'];
          } else if (normalized == 'sigiriya_rock_fortress') {
            ratings = ratingsMap['sigiriya'];
          } else if (normalized == 'sigiriya') {
            ratings = ratingsMap['sigiriya_rock_fortress'];
          } else if (normalized == 'ibbankatuwa_megalithic_tombs') {
            ratings = ratingsMap['ibbankatuwa'];
          } else if (normalized == 'ibbankatuwa') {
            ratings = ratingsMap['ibbankatuwa_megalithic_tombs'];
          } else if (normalized == 'galle_dutch_fort_lighthouse') {
            ratings = ratingsMap['galle_fort'] ?? ratingsMap['galle'];
          } else if (normalized == 'galle_fort' || normalized == 'galle') {
            ratings = ratingsMap['galle_dutch_fort_lighthouse'];
          } else if (normalized == 'star_fort_matara') {
            ratings = ratingsMap['star_fort'];
          } else if (normalized == 'star_fort') {
            ratings = ratingsMap['star_fort_matara'];
          } else if (normalized == 'mulkirigala_rock_temple') {
            ratings = ratingsMap['mulkirigala'];
          } else if (normalized == 'mulkirigala') {
            ratings = ratingsMap['mulkirigala_rock_temple'];
          } else if (normalized == 'kushta_raja_gala') {
            ratings = ratingsMap['kushta_raja'];
          } else if (normalized == 'kushta_raja') {
            ratings = ratingsMap['kushta_raja_gala'];
          }
        }
        if (ratings == null || ratings.isEmpty) {
          if (normalized.endsWith('a')) {
            ratings =
                ratingsMap[normalized.substring(0, normalized.length - 1)];
          } else {
            ratings = ratingsMap['${normalized}a'];
          }
        }

        if (ratings != null && ratings.isNotEmpty) {
          final sum = ratings.reduce((a, b) => a + b);
          final avg = sum / ratings.length;
          results[id] =
              PlaceReviewStats(count: ratings.length, average: avg);
        } else {
          results[id] = const PlaceReviewStats(count: 0, average: 0.0);
        }
      }
    } catch (_) {
      for (final id in placeIds) {
        results[id] = await getRealPlaceStats(id);
      }
    }
    return results;
  }
}
