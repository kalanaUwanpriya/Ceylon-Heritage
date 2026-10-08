import 'package:flutter_test/flutter_test.dart';
import 'package:ceylon_heritage/models/historical_place.dart';
import 'package:ceylon_heritage/services/route_generation_service.dart';

void main() {
  group('Critical Database Rating Filter Requirements', () {
    final placeA = HistoricalPlace(
      id: 'sri_maha_bodhi',
      name: 'Sri Maha Bodhi',
      destination: 'Anuradhapura',
      description: 'The sacred fig tree.',
      location: 'Anuradhapura',
      image: 'assets/images/Auradapura 2.png',
    );

    final placeB = HistoricalPlace(
      id: 'place_with_low_rating',
      name: 'Low Rating Monument',
      destination: 'Anuradhapura',
      description: 'Monument with lower reviews.',
      location: 'Anuradhapura',
      image: 'assets/images/anuradhapura.png',
    );

    final placeC = HistoricalPlace(
      id: 'unreviewed_place',
      name: 'Unreviewed Site',
      destination: 'Anuradhapura',
      description: 'Site with no reviews yet.',
      location: 'Anuradhapura',
      image: 'assets/images/thuparamaya.png',
    );

    final filteredA = FilteredPlace(
      place: placeA,
      realAverageRating: 2.8,
      reviewCount: 5,
    );

    final filteredB = FilteredPlace(
      place: placeB,
      realAverageRating: 1.67,
      reviewCount: 3,
    );

    final filteredC = FilteredPlace(
      place: placeC,
      realAverageRating: 0.0,
      reviewCount: 0,
    );

    final allPlaces = [filteredA, filteredB, filteredC];

    test('Selected "Any" → no rating restriction (all places eligible)', () {
      final eligible =
          RouteGenerationService.filterEligiblePlaces(allPlaces, 'Any');

      expect(eligible.length, 3);
      expect(eligible.map((e) => e.placeId),
          containsAll(['sri_maha_bodhi', 'place_with_low_rating', 'unreviewed_place']));
    });

    test('Selected "1 Star" → average rating >= 1.0 (excludes unreviewed 0.0)', () {
      final eligible =
          RouteGenerationService.filterEligiblePlaces(allPlaces, '1 Star');

      expect(eligible.length, 2);
      expect(eligible.map((e) => e.placeId),
          containsAll(['sri_maha_bodhi', 'place_with_low_rating']));
      expect(eligible.map((e) => e.placeId), isNot(contains('unreviewed_place')));
    });

    test('Selected "2 Star" → average rating >= 2.0 (excludes 1.67 ⭐ and unreviewed)', () {
      final eligible =
          RouteGenerationService.filterEligiblePlaces(allPlaces, '2 Star');

      expect(eligible.length, 1);
      expect(eligible.first.placeId, 'sri_maha_bodhi');
      expect(eligible.map((e) => e.placeId), isNot(contains('place_with_low_rating')));
    });

    test('Example from prompt: Place with 4.6 included in 2 Star, Place with 1.67 excluded', () {
      final testSriMahaBodhi = FilteredPlace(
        place: placeA,
        realAverageRating: 4.6, // from example
        reviewCount: 5,
      );
      final testOtherPlace = FilteredPlace(
        place: placeB,
        realAverageRating: 1.67, // from example
        reviewCount: 3,
      );

      final result = RouteGenerationService.filterEligiblePlaces(
        [testSriMahaBodhi, testOtherPlace],
        '2 Star',
      );

      expect(result.length, 1);
      expect(result.first.place.name, 'Sri Maha Bodhi');
    });
  });

  group('Customized Pace Timing & Capacity Logic Tests', () {
    final ruwanwelisaya = FilteredPlace(
      place: HistoricalPlace(
        id: 'ruwanwelisaya',
        name: 'Ruwanwelisaya',
        destination: 'Anuradhapura',
        description: 'Great Stupa',
        location: 'Anuradhapura',
        image: 'assets/images/anuradhapura.png',
      ),
      realAverageRating: 3.0,
      reviewCount: 10,
    );

    final sriMahaBodhi = FilteredPlace(
      place: HistoricalPlace(
        id: 'sri_maha_bodhi',
        name: 'Sri Maha Bodhi',
        destination: 'Anuradhapura',
        description: 'Sacred Fig Tree',
        location: 'Anuradhapura',
        image: 'assets/images/Auradapura 2.png',
      ),
      realAverageRating: 3.0,
      reviewCount: 15,
    );

    final thuparamaya = FilteredPlace(
      place: HistoricalPlace(
        id: 'thuparamaya',
        name: 'Thuparamaya',
        destination: 'Anuradhapura',
        description: 'First stupa',
        location: 'Anuradhapura',
        image: 'assets/images/thuparamaya.png',
      ),
      realAverageRating: 2.8,
      reviewCount: 8,
    );

    final jetavanaramaya = FilteredPlace(
      place: HistoricalPlace(
        id: 'jetavanaramaya',
        name: 'Jetavanaramaya',
        destination: 'Anuradhapura',
        description: 'Ancient Monastery Stupa',
        location: 'Anuradhapura',
        image: 'assets/images/jetavanaramaya.png',
      ),
      realAverageRating: 2.9,
      reviewCount: 12,
    );

    final abhayagiri = FilteredPlace(
      place: HistoricalPlace(
        id: 'abhayagiri',
        name: 'Abhayagiri',
        destination: 'Anuradhapura',
        description: 'Monastery Site',
        location: 'Anuradhapura',
        image: 'assets/images/anurapura 5.png',
      ),
      realAverageRating: 2.7,
      reviewCount: 9,
    );

    final fivePlaces = [
      ruwanwelisaya,
      sriMahaBodhi,
      thuparamaya,
      jetavanaramaya,
      abhayagiri,
    ];

    test('1. QUICK pace: Visit duration < 30 minutes for each place (15-29 min)', () {
      final duration1 = RouteGenerationService.getVisitDurationMinutes('ruwanwelisaya', 'Quick', 0);
      final duration2 = RouteGenerationService.getVisitDurationMinutes('sri_maha_bodhi', 'Quick', 1);
      final duration3 = RouteGenerationService.getVisitDurationMinutes('thuparamaya', 'Quick', 2);

      expect(duration1, lessThan(30));
      expect(duration1, greaterThanOrEqualTo(15));
      expect(duration1, 25); // exactly 25m as in user prompt

      expect(duration2, lessThan(30));
      expect(duration2, 20); // exactly 20m as in user prompt

      expect(duration3, lessThan(30));
      expect(duration3, 28); // exactly 28m as in user prompt

      expect(RouteGenerationService.formatStayDuration(duration1), '25m');
      expect(RouteGenerationService.formatStayDuration(duration2), '20m');
      expect(RouteGenerationService.formatStayDuration(duration3), '28m');
    });

    test('2. MODERATE pace: Visit duration between 30 and 60 minutes (30-60 min)', () {
      final duration1 = RouteGenerationService.getVisitDurationMinutes('ruwanwelisaya', 'Moderate', 0);
      final duration2 = RouteGenerationService.getVisitDurationMinutes('sri_maha_bodhi', 'Moderate', 1);
      final duration3 = RouteGenerationService.getVisitDurationMinutes('thuparamaya', 'Moderate', 2);

      expect(duration1, inInclusiveRange(30, 60));
      expect(duration1, 50); // exactly 50m as in user prompt

      expect(duration2, inInclusiveRange(30, 60));
      expect(duration2, 45); // exactly 45m as in user prompt

      expect(duration3, inInclusiveRange(30, 60));
      expect(duration3, 40); // exactly 40m as in user prompt

      expect(RouteGenerationService.formatStayDuration(duration1), '50m');
      expect(RouteGenerationService.formatStayDuration(duration2), '45m');
      expect(RouteGenerationService.formatStayDuration(duration3), '40m');
    });

    test('3. LEISURELY pace: Visit duration > 1 hour (60-90 min) with format e.g. 1h 15m', () {
      final duration1 = RouteGenerationService.getVisitDurationMinutes('ruwanwelisaya', 'Leisurely', 0);
      final duration2 = RouteGenerationService.getVisitDurationMinutes('sri_maha_bodhi', 'Leisurely', 1);
      final duration3 = RouteGenerationService.getVisitDurationMinutes('thuparamaya', 'Leisurely', 2);

      expect(duration1, greaterThan(60));
      expect(duration1, 75); // 1h 15m as in user prompt

      expect(duration2, greaterThan(60));
      expect(duration2, 70); // 1h 10m as in user prompt

      expect(duration3, greaterThan(60));
      expect(duration3, 80); // 1h 20m as in user prompt

      expect(RouteGenerationService.formatStayDuration(duration1), '1h 15m');
      expect(RouteGenerationService.formatStayDuration(duration2), '1h 10m');
      expect(RouteGenerationService.formatStayDuration(duration3), '1h 20m');
    });

    test('4. Timeline arrival times match exact prompt example for QUICK', () {
      // 09:00 AM Ruwanwelisaya (25m) -> 12 min walk -> 09:37 AM Sri Maha Bodhi (20m)
      final tour = RouteGenerationService.buildTourRoute(
        eligiblePlaces: [ruwanwelisaya, sriMahaBodhi],
        tempo: 'Quick',
        timeAvailable: '8h',
        ratingFilter: 'Any',
        destinationName: 'Anuradhapura',
      );

      expect(tour.stops.length, 2);

      // Stop 1
      expect(tour.stops[0].place.name, 'Ruwanwelisaya');
      expect(tour.stops[0].arrivalTime, '9:00 AM');
      expect(tour.stops[0].stayDurationLabel, '25m');
      expect(tour.stops[0].departureTime, '9:25 AM');
      expect(tour.stops[0].walkMinutesToNext, 12);

      // Stop 2: 9:25 AM + 12 min walk = 9:37 AM!
      expect(tour.stops[1].place.name, 'Sri Maha Bodhi');
      expect(tour.stops[1].arrivalTime, '9:37 AM');
      expect(tour.stops[1].stayDurationLabel, '20m');
    });

    test('5. BREAK RULE: 30m Quick / 50m Moderate / 60m Leisurely after 4 places', () {
      expect(RouteGenerationService.getBreakMinutes('Quick'), 30);
      expect(RouteGenerationService.getBreakMinutes('Moderate'), 50);
      expect(RouteGenerationService.getBreakMinutes('Leisurely'), 60);

      // In moderate tour with 5 places:
      final tour = RouteGenerationService.buildTourRoute(
        eligiblePlaces: fivePlaces,
        tempo: 'Moderate',
        timeAvailable: '8h',
        ratingFilter: 'Any',
        destinationName: 'Anuradhapura',
      );

      // Stop 4 should have break after it before Stop 5
      expect(tour.stops[3].hasBreakAfter, isTrue);
      expect(tour.stops[3].breakMinutesAfter, 50);

      // Other stops should not have break after them
      expect(tour.stops[0].hasBreakAfter, isFalse);
      expect(tour.stops[1].hasBreakAfter, isFalse);
      expect(tour.stops[2].hasBreakAfter, isFalse);
    });

    test('6. Dynamic places capacity: In 8-hour time, Leisurely fits fewer places than Quick/Moderate', () {
      final leisurelyTour = RouteGenerationService.buildTourRoute(
        eligiblePlaces: fivePlaces,
        tempo: 'Leisurely',
        timeAvailable: '8h', // 480 min: places take 75+12+70+10+80+18+85+60 break = 410m, adding 5th place exceeds 480m!
        ratingFilter: 'Any',
        destinationName: 'Anuradhapura',
      );

      final quickTour = RouteGenerationService.buildTourRoute(
        eligiblePlaces: fivePlaces,
        tempo: 'Quick',
        timeAvailable: '8h',
        ratingFilter: 'Any',
        destinationName: 'Anuradhapura',
      );

      expect(leisurelyTour.stops.length, 4);
      expect(quickTour.stops.length, 5);
      expect(quickTour.stops.length, greaterThan(leisurelyTour.stops.length));
    });
  });
}
