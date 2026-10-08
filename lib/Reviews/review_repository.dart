import 'models/review.dart';
import 'services/review_service.dart';

abstract class ReviewRepository {
  Future<Review> createReview({
    required String placeId,
    required String placeName,
    required String placeImage,
    required String location,
    required int rating,
    String? userId,
  });

  Future<void> updateReview(String reviewId, int newRating);

  Future<void> deleteReview(String reviewId);

  Stream<List<Review>> getPlaceReviews(String placeId);

  Stream<PlaceReviewStats> getPlaceReviewStats(String placeId);

  Stream<List<Review>> getCurrentUserReviews();

  Future<Review?> getUserReviewForPlace(String placeId, {String? userId});

  Stream<Review?> watchUserReviewForPlace(String placeId, {String? userId});

  Future<bool> hasUserReviewedPlace(String placeId, {String? userId});

  double calculateAverageRating(List<Review> reviews);
}

class FirestoreReviewRepository implements ReviewRepository {
  final ReviewService _service;

  FirestoreReviewRepository({ReviewService? service})
      : _service = service ?? ReviewService();

  @override
  Future<Review> createReview({
    required String placeId,
    required String placeName,
    required String placeImage,
    required String location,
    required int rating,
    String? userId,
  }) {
    return _service.createReview(
      placeId: placeId,
      placeName: placeName,
      placeImage: placeImage,
      location: location,
      rating: rating,
      userId: userId,
    );
  }

  @override
  Future<void> updateReview(String reviewId, int newRating) {
    return _service.updateReview(reviewId, newRating);
  }

  @override
  Future<void> deleteReview(String reviewId) {
    return _service.deleteReview(reviewId);
  }

  @override
  Stream<List<Review>> getPlaceReviews(String placeId) {
    return _service.getPlaceReviews(placeId);
  }

  @override
  Stream<PlaceReviewStats> getPlaceReviewStats(String placeId) {
    return _service.getPlaceReviewStats(placeId);
  }

  @override
  Stream<List<Review>> getCurrentUserReviews() {
    return _service.getCurrentUserReviews();
  }

  @override
  Future<Review?> getUserReviewForPlace(String placeId, {String? userId}) {
    return _service.getUserReviewForPlace(placeId, userId: userId);
  }

  @override
  Stream<Review?> watchUserReviewForPlace(String placeId, {String? userId}) {
    return _service.watchUserReviewForPlace(placeId, userId: userId);
  }

  @override
  Future<bool> hasUserReviewedPlace(String placeId, {String? userId}) {
    return _service.hasUserReviewedPlace(placeId, userId: userId);
  }

  @override
  double calculateAverageRating(List<Review> reviews) {
    return _service.calculateAverageRating(reviews);
  }
}
