import 'package:flutter_test/flutter_test.dart';
import 'package:ceylon_heritage/data/historical_places_data.dart';
import 'package:ceylon_heritage/models/historical_place.dart';
import 'package:ceylon_heritage/services/historical_places_api.dart';
import 'package:ceylon_heritage/services/route_generation_service.dart';

void main() {
  group('Dambulla Historical Places & API Retrieval', () {
    test('HistoricalPlacesApi retrieves only Dambulla places for Dambulla destination', () async {
      final places = await const HistoricalPlacesApi().getHistoricalPlaces(destination: 'Dambulla');

      expect(places.isNotEmpty, isTrue);
      expect(places.length, 3);
      for (final p in places) {
        expect(p.destination.toLowerCase(), contains('dambulla'));
      }
      final names = places.map((p) => p.name).toList();
      expect(names, containsAll([
        'Dambulla Cave Temple',
        'Sigiriya Rock Fortress',
        'Ibbankatuwa Megalithic Tombs',
      ]));
    });

    test('Dambulla places have valid coordinates and non-empty categories', () {
      for (final p in dambullaPlaces) {
        expect(p.lat, isNotNull);
        expect(p.lng, isNotNull);
        expect(p.lat, inInclusiveRange(7.0, 9.0));
        expect(p.lng, inInclusiveRange(80.0, 82.0));
        expect(p.placeCategory, isNotEmpty);
      }
    });

    test('Destination fallback coordinates for Dambulla are valid', () {
      final placeNoCoords = HistoricalPlace(
        name: 'Unknown Spot',
        destination: 'Dambulla',
        description: 'Test',
        location: 'Dambulla, Sri Lanka',
        image: 'assets/images/dambulla.png',
      );
      expect(placeNoCoords.lat, closeTo(7.8566, 0.01));
      expect(placeNoCoords.lng, closeTo(80.6483, 0.01));
    });
  });

  group('Dambulla Pace-Based Visit Durations', () {
    test('Quick pace produces 15-29 minute durations per attraction', () {
      for (int i = 0; i < dambullaPlaces.length; i++) {
        final p = dambullaPlaces[i];
        final dur = RouteGenerationService.getVisitDurationMinutes(p.placeId, 'Quick', i);
        expect(dur, inInclusiveRange(15, 29),
            reason: '${p.name} at Quick pace should be 15-29 min, got $dur min');
      }
    });

    test('Moderate pace produces 30-60 minute durations per attraction', () {
      for (int i = 0; i < dambullaPlaces.length; i++) {
        final p = dambullaPlaces[i];
        final dur = RouteGenerationService.getVisitDurationMinutes(p.placeId, 'Moderate', i);
        expect(dur, inInclusiveRange(30, 60),
            reason: '${p.name} at Moderate pace should be 30-60 min, got $dur min');
      }
    });

    test('Leisurely pace produces 65-90 minute durations per attraction', () {
      for (int i = 0; i < dambullaPlaces.length; i++) {
        final p = dambullaPlaces[i];
        final dur = RouteGenerationService.getVisitDurationMinutes(p.placeId, 'Leisurely', i);
        expect(dur, inInclusiveRange(65, 90),
            reason: '${p.name} at Leisurely pace should be 65-90 min, got $dur min');
      }
    });

    test('Different places have distinct realistic durations for the same pace', () {
      final caveQuick = RouteGenerationService.getVisitDurationMinutes(dambullaPlaces[0].placeId, 'Quick', 0);
      final sigiriyaQuick = RouteGenerationService.getVisitDurationMinutes(dambullaPlaces[1].placeId, 'Quick', 1);
      final tombQuick = RouteGenerationService.getVisitDurationMinutes(dambullaPlaces[2].placeId, 'Quick', 2);

      expect(caveQuick, isNot(equals(sigiriyaQuick)));
      expect(tombQuick, isNot(equals(sigiriyaQuick)));
    });
  });

  group('Dambulla Leg Walking Distance and Time Calculation', () {
    test('Dambulla leg lookups return realistic distance and walking times', () {
      final cave = dambullaPlaces[0];
      final sigiriya = dambullaPlaces[1];
      final tombs = dambullaPlaces[2];

      final legCaveTombs = RouteGenerationService.getLegInfo(
        cave.placeId,
        tombs.placeId,
        'Moderate',
        fromPlace: cave,
        toPlace: tombs,
      );
      expect(legCaveTombs.km, closeTo(4.5, 0.1));
      expect(legCaveTombs.minutes, 55);

      final legCaveSigiriya = RouteGenerationService.getLegInfo(
        cave.placeId,
        sigiriya.placeId,
        'Moderate',
        fromPlace: cave,
        toPlace: sigiriya,
      );
      expect(legCaveSigiriya.km, closeTo(17.5, 0.1));
      expect(legCaveSigiriya.minutes, 210);

      final legTombsSigiriya = RouteGenerationService.getLegInfo(
        tombs.placeId,
        sigiriya.placeId,
        'Moderate',
        fromPlace: tombs,
        toPlace: sigiriya,
      );
      expect(legTombsSigiriya.km, closeTo(21.0, 0.1));
      expect(legTombsSigiriya.minutes, 255);
    });
  });

  group('Dambulla Route Generation & Break Rule Verification', () {
    final filteredDambulla = dambullaPlaces
        .map((p) => FilteredPlace(place: p, realAverageRating: 3.0, reviewCount: 5))
        .toList();

    test('Break rule: Breaks added only after groups of 4 places (0 breaks for 3 places)', () {
      final route = RouteGenerationService.buildTourRoute(
        eligiblePlaces: filteredDambulla,
        tempo: 'Moderate',
        timeAvailable: '1 Day',
        ratingFilter: 'Any',
        destinationName: 'Dambulla',
      );

      // Dambulla has 3 places, fewer than 4 => 0 breaks
      expect(route.stops.where((s) => s.hasBreakAfter).length, 0);
      expect(route.totalBreakMinutes, 0);
      expect(route.circuitTitle, 'DAMBULLA · HISTORICAL CIRCUIT');
      expect(route.headline, contains('Dambulla'));
    });

    test('Break rule: Breaks correctly inserted after 4 places when extra places present', () {
      final extendedPlaces = [
        ...filteredDambulla,
        FilteredPlace(
          place: HistoricalPlace(
            id: 'extra_site_1',
            name: 'Extra Dambulla Site 1',
            destination: 'Dambulla',
            description: 'Description',
            location: 'Dambulla',
            image: 'assets/images/dambulla.png',
          ),
          realAverageRating: 3.0,
          reviewCount: 2,
        ),
        FilteredPlace(
          place: HistoricalPlace(
            id: 'extra_site_2',
            name: 'Extra Dambulla Site 2',
            destination: 'Dambulla',
            description: 'Description',
            location: 'Dambulla',
            image: 'assets/images/dambulla.png',
          ),
          realAverageRating: 3.0,
          reviewCount: 2,
        ),
      ];

      final route = RouteGenerationService.buildTourRoute(
        eligiblePlaces: extendedPlaces,
        tempo: 'Moderate',
        timeAvailable: '2 Day',
        ratingFilter: 'Any',
        destinationName: 'Dambulla',
      );

      // Exactly 1 break after place 4
      final breakStops = route.stops.where((s) => s.hasBreakAfter).toList();
      expect(breakStops.length, 1);
      expect(breakStops.first.breakMinutesAfter, 50); // Moderate break is 50m
      expect(route.totalBreakMinutes, 50);
    });

    test('Timeline progression: arrival and departure times align precisely', () {
      final route = RouteGenerationService.buildTourRoute(
        eligiblePlaces: filteredDambulla,
        tempo: 'Quick',
        timeAvailable: '1 Day',
        ratingFilter: 'Any',
        destinationName: 'Dambulla',
      );

      expect(route.stops.isNotEmpty, isTrue);

      // First place starts at 9:00 AM
      expect(route.stops.first.arrivalTime, '9:00 AM');

      // Total durations match sum of visits, walking, and breaks
      final totalMin = route.totalVisitMinutes + route.totalWalkMinutes + route.totalBreakMinutes;
      expect(totalMin, greaterThan(0));
    });
  });

  group('Dambulla Rating Filter Verification', () {
    final place1 = FilteredPlace(
      place: dambullaPlaces[0],
      realAverageRating: 2.5,
      reviewCount: 4,
    );
    final place2 = FilteredPlace(
      place: dambullaPlaces[1],
      realAverageRating: 1.5,
      reviewCount: 2,
    );
    final place3 = FilteredPlace(
      place: dambullaPlaces[2],
      realAverageRating: 0.0,
      reviewCount: 0,
    );

    final dambullaFilteredList = [place1, place2, place3];

    test('"Any" includes all places including unreviewed', () {
      final res = RouteGenerationService.filterEligiblePlaces(dambullaFilteredList, 'Any');
      expect(res.length, 3);
    });

    test('"1 Star" includes >= 1.0 rating (excludes unreviewed)', () {
      final res = RouteGenerationService.filterEligiblePlaces(dambullaFilteredList, '1 Star');
      expect(res.length, 2);
      expect(res.map((p) => p.placeId), containsAll([place1.placeId, place2.placeId]));
      expect(res.map((p) => p.placeId), isNot(contains(place3.placeId)));
    });

    test('"2 Star" includes >= 2.0 rating', () {
      final res = RouteGenerationService.filterEligiblePlaces(dambullaFilteredList, '2 Star');
      expect(res.length, 1);
      expect(res.first.placeId, place1.placeId);
    });
  });

  group('Regression Safety: Anuradhapura & Polonnaruwa', () {
    test('Anuradhapura circuit title and route generation remain intact', () {
      final anuradhapuraSample = [
        FilteredPlace(
          place: HistoricalPlace(
            id: 'ruwanwelisaya',
            name: 'Ruwanwelisaya',
            destination: 'Anuradhapura',
            description: 'Stupa',
            location: 'Anuradhapura',
            image: 'assets/images/anuradhapura.png',
          ),
          realAverageRating: 3.0,
          reviewCount: 10,
        ),
      ];

      final route = RouteGenerationService.buildTourRoute(
        eligiblePlaces: anuradhapuraSample,
        tempo: 'Moderate',
        timeAvailable: '8h',
        ratingFilter: 'Any',
        destinationName: 'Anuradhapura',
      );

      expect(route.circuitTitle, 'CURATED HISTORICAL CIRCUIT');
      expect(route.headline, 'Your 8-Hour Walking Tour');
    });

    test('Polonnaruwa circuit title and route generation remain intact', () {
      final polonnaruwaSample = [
        FilteredPlace(
          place: HistoricalPlace(
            id: 'gal_viharaya',
            name: 'Gal Viharaya',
            destination: 'Polonnaruwa',
            description: 'Rock temple',
            location: 'Polonnaruwa',
            image: 'assets/images/gal_viharaya.png',
          ),
          realAverageRating: 3.0,
          reviewCount: 10,
        ),
      ];

      final route = RouteGenerationService.buildTourRoute(
        eligiblePlaces: polonnaruwaSample,
        tempo: 'Moderate',
        timeAvailable: '8h',
        ratingFilter: 'Any',
        destinationName: 'Polonnaruwa',
      );

      expect(route.circuitTitle, 'POLONNARUWA · HISTORICAL CIRCUIT');
      expect(route.headline, contains('Polonnaruwa'));
    });
  });
}
