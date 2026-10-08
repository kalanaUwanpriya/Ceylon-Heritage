import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceylon_heritage/Reviews/models/review.dart';
import 'package:ceylon_heritage/Reviews/services/review_service.dart';
import 'package:ceylon_heritage/Reviews/widgets/rating_stars.dart';

void main() {
  group('Review Model & Logic Tests', () {
    test('Review model clamps rating to 1..3 stars', () {
      final reviewLow = Review.fromMap({
        'userId': 'user123',
        'placeId': 'ruwanwelisaya',
        'placeName': 'Ruwanwelisaya',
        'placeImage': 'assets/images/anuradhapura.png',
        'location': 'Anuradhapura',
        'rating': 0, // invalid low
      }, id: 'test_doc_1');

      expect(reviewLow.rating, 1);

      final reviewHigh = Review.fromMap({
        'userId': 'user123',
        'placeId': 'ruwanwelisaya',
        'placeName': 'Ruwanwelisaya',
        'placeImage': 'assets/images/anuradhapura.png',
        'location': 'Anuradhapura',
        'rating': 5, // invalid high (must never be 5 stars)
      }, id: 'test_doc_2');

      expect(reviewHigh.rating, 3);

      final reviewValid = Review.fromMap({
        'userId': 'user123',
        'placeId': 'ruwanwelisaya',
        'placeName': 'Ruwanwelisaya',
        'placeImage': 'assets/images/anuradhapura.png',
        'location': 'Anuradhapura',
        'rating': 2,
      }, id: 'test_doc_3');

      expect(reviewValid.rating, 2);
    });

    test('Review toMap and toFirestore formats rating as integer within 1..3', () {
      final review = Review(
        id: 'user1_ruwanwelisaya',
        userId: 'user1',
        placeId: 'ruwanwelisaya',
        placeName: 'Ruwanwelisaya',
        placeImage: 'assets/images/anuradhapura.png',
        location: 'Anuradhapura',
        rating: 2,
      );

      final map = review.toFirestore();
      expect(map['rating'], isA<int>());
      expect(map['rating'], 2);
      expect(map['userId'], 'user1');
      expect(map['placeId'], 'ruwanwelisaya');
    });

    test('Average rating calculation matches requirements', () {
      final service = ReviewService();

      // Empty list
      expect(service.calculateAverageRating([]), 0.0);

      // Example from prompt: 3, 2, 2, 3, 1 -> avg 2.2
      final reviews = [
        const Review(
          id: '1',
          userId: 'u1',
          placeId: 'p1',
          placeName: 'P',
          placeImage: 'img',
          location: 'loc',
          rating: 3,
        ),
        const Review(
          id: '2',
          userId: 'u2',
          placeId: 'p1',
          placeName: 'P',
          placeImage: 'img',
          location: 'loc',
          rating: 2,
        ),
        const Review(
          id: '3',
          userId: 'u3',
          placeId: 'p1',
          placeName: 'P',
          placeImage: 'img',
          location: 'loc',
          rating: 2,
        ),
        const Review(
          id: '4',
          userId: 'u4',
          placeId: 'p1',
          placeName: 'P',
          placeImage: 'img',
          location: 'loc',
          rating: 3,
        ),
        const Review(
          id: '5',
          userId: 'u5',
          placeId: 'p1',
          placeName: 'P',
          placeImage: 'img',
          location: 'loc',
          rating: 1,
        ),
      ];

      final avg = service.calculateAverageRating(reviews);
      expect(avg, closeTo(2.2, 0.01));

      final stats = PlaceReviewStats(count: reviews.length, average: avg);
      expect(stats.formattedAverage, '2.2');
      expect(stats.formattedCount, '5 reviews');
    });

    test('Unique review ID generation enforces userId + placeId', () {
      final service = ReviewService();
      final reviewId = service.generateReviewId('userA', 'ruwanwelisaya');
      expect(reviewId, 'userA_ruwanwelisaya');
    });
  });

  group('RatingStars Widget Tests', () {
    testWidgets('RatingStars renders exactly 3 stars, never 4 or 5', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RatingStars(rating: 2),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsNWidgets(3));

      // 2 filled stars, 1 outline star
      final filledFinder = find.byIcon(Icons.star_rounded);
      final outlineFinder = find.byIcon(Icons.star_outline_rounded);
      expect(filledFinder, findsNWidgets(2));
      expect(outlineFinder, findsNWidgets(1));
    });

    testWidgets('Interactive RatingStars allows tapping 1..3 stars', (tester) async {
      int? selected;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RatingStars(
              rating: 1,
              isInteractive: true,
              onRatingChanged: (rating) {
                selected = rating;
              },
            ),
          ),
        ),
      );

      final starWidgets = find.byType(GestureDetector);
      expect(starWidgets, findsNWidgets(3));

      // Tap 3rd star
      await tester.tap(starWidgets.at(2));
      expect(selected, 3);

      // Tap 2nd star
      await tester.tap(starWidgets.at(1));
      expect(selected, 2);
    });
  });
}
