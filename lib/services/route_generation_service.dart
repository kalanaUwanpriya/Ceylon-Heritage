import 'dart:math' as math;

import '../models/historical_place.dart';
import '../Reviews/models/review.dart';
import '../Reviews/services/review_service.dart';
import 'historical_places_api.dart';

/// Represents a place that has been processed with its real database review statistics.
class FilteredPlace {
  final HistoricalPlace place;
  final double realAverageRating;
  final int reviewCount;
  final List<Review> reviews;

  const FilteredPlace({
    required this.place,
    required this.realAverageRating,
    required this.reviewCount,
    this.reviews = const [],
  });

  String get placeId => place.placeId;
}

/// Represents an individual stop in the generated walking tour route.
class WalkingRouteStop {
  final int stepNumber; // 1, 2, 3...
  final HistoricalPlace place;
  final double realAverageRating;
  final int reviewCount;
  final String arrivalTime; // e.g. "09:00 AM"
  final String departureTime; // e.g. "09:25 AM"
  final int stayDurationMinutes; // e.g. 25, 50, 75
  final String stayDurationLabel; // e.g. "25m", "50m", "1h 15m"
  final double distanceToNextKm; // e.g. 0.85
  final String distanceToNextLabel; // e.g. "850 m"
  final int walkMinutesToNext; // e.g. 12
  final String walkTimeToNextLabel; // e.g. "12 min walk"
  final bool hasBreakAfter; // true after every 4 selected places
  final int breakMinutesAfter; // e.g. 30, 50, 60
  final bool hasAudioGuide;
  final bool hasParking;
  final bool hasInformation;

  const WalkingRouteStop({
    required this.stepNumber,
    required this.place,
    required this.realAverageRating,
    required this.reviewCount,
    required this.arrivalTime,
    required this.departureTime,
    required this.stayDurationMinutes,
    required this.stayDurationLabel,
    this.distanceToNextKm = 0.0,
    this.distanceToNextLabel = '',
    this.walkMinutesToNext = 0,
    this.walkTimeToNextLabel = '',
    this.hasBreakAfter = false,
    this.breakMinutesAfter = 0,
    this.hasAudioGuide = true,
    this.hasParking = true,
    this.hasInformation = true,
  });
}

/// Complete generated walking tour object.
class GeneratedWalkingTour {
  final String destinationName;
  final String circuitTitle;
  final String headline;
  final String description;
  final String totalDurationLabel; // e.g. "7h 45m", "8h 0m"
  final String totalDistanceLabel; // e.g. "12.6 km"
  final String totalVisitTimeLabel; // e.g. "4h 25m"
  final String totalWalkTimeLabel; // e.g. "1h 15m"
  final String totalBreakTimeLabel; // e.g. "50m"
  final int totalVisitMinutes;
  final int totalWalkMinutes;
  final int totalBreakMinutes;
  final String tempo;
  final String timeAvailable;
  final String ratingFilter;
  final List<WalkingRouteStop> stops;

  const GeneratedWalkingTour({
    required this.destinationName,
    required this.circuitTitle,
    required this.headline,
    required this.description,
    required this.totalDurationLabel,
    required this.totalDistanceLabel,
    this.totalVisitTimeLabel = '0m',
    this.totalWalkTimeLabel = '0m',
    this.totalBreakTimeLabel = '0m',
    this.totalVisitMinutes = 0,
    this.totalWalkMinutes = 0,
    this.totalBreakMinutes = 0,
    required this.tempo,
    this.timeAvailable = '1 Day',
    required this.ratingFilter,
    required this.stops,
  });

  bool get isEmpty => stops.isEmpty;
}

/// The Service responsible for executing the 6-step filtering process
/// and generating the walking tour route using REAL database ratings and
/// customized pace timing logic.
class RouteGenerationService {
  final HistoricalPlacesApi _placesApi;
  final ReviewService _reviewService;

  RouteGenerationService({
    HistoricalPlacesApi? placesApi,
    ReviewService? reviewService,
  })  : _placesApi = placesApi ?? const HistoricalPlacesApi(),
        _reviewService = reviewService ?? ReviewService();

  /// Executes the 6-STEP DATABASE FILTERING PROCESS:
  ///
  /// 1. Get historical places from the existing API.
  /// 2. Identify the place ID for each place.
  /// 3. Use that place ID to obtain its review/rating data from the EXISTING database.
  /// 4. Calculate/use the real average star rating for that place.
  /// 5. Apply the user's selected filter:
  ///    - Any → no rating restriction
  ///    - 1 Star → average rating >= 1.0 (from real reviews)
  ///    - 2 Star → average rating >= 2.0 (from real reviews)
  /// 6. Only after this filtering, send remaining places to the route-generation algorithm.
  Future<GeneratedWalkingTour> generateTour({
    required String tempo,
    required String timeAvailable,
    required String ratingFilter,
    String? destinationName,
  }) async {
    // -------------------------------------------------------------
    // STEP 1: Get historical places from the existing API
    // -------------------------------------------------------------
    final List<HistoricalPlace> rawPlaces =
        await _placesApi.getHistoricalPlaces(destination: destinationName);

    // -------------------------------------------------------------
    // STEP 2: Identify the place ID for each place
    // -------------------------------------------------------------
    final List<String> placeIds = rawPlaces.map((p) => p.placeId).toList();

    // -------------------------------------------------------------
    // STEP 3: Use place ID to obtain review/rating data from EXISTING database
    // -------------------------------------------------------------
    final Map<String, PlaceReviewStats> databaseStats =
        await _reviewService.getBatchRealPlaceStats(placeIds);

    // -------------------------------------------------------------
    // STEP 4: Calculate/use the real average star rating for each place
    // -------------------------------------------------------------
    final List<FilteredPlace> placesWithRealRatings = rawPlaces.map((place) {
      final stats = databaseStats[place.placeId] ??
          const PlaceReviewStats(count: 0, average: 0.0);
      return FilteredPlace(
        place: place,
        realAverageRating: stats.average,
        reviewCount: stats.count,
      );
    }).toList();

    // -------------------------------------------------------------
    // STEP 5: Apply user's selected filter
    // -------------------------------------------------------------
    final List<FilteredPlace> eligiblePlaces =
        filterEligiblePlaces(placesWithRealRatings, ratingFilter);

    // -------------------------------------------------------------
    // STEP 6: Send remaining places to the route-generation algorithm
    // -------------------------------------------------------------
    return buildTourRoute(
      eligiblePlaces: eligiblePlaces,
      tempo: tempo,
      timeAvailable: timeAvailable,
      ratingFilter: ratingFilter,
      destinationName: destinationName ?? 'Anuradhapura',
    );
  }

  /// Pure filtering logic for step 5, exposed for unit testing.
  static List<FilteredPlace> filterEligiblePlaces(
    List<FilteredPlace> places,
    String ratingFilter,
  ) {
    return places.where((item) {
      if (ratingFilter == '1 Star') {
        return item.reviewCount > 0 && item.realAverageRating >= 1.0;
      } else if (ratingFilter == '2 Star') {
        return item.reviewCount > 0 && item.realAverageRating >= 2.0;
      }
      // 'Any' allows all places, including unreviewed
      return true;
    }).toList();
  }

  /// Calculates the realistic visit duration for a place based strictly on pace:
  ///
  /// 1. QUICK: Spend LESS THAN 30 minutes at each place (15–29 min).
  /// 2. MODERATE: Spend BETWEEN 30 minutes and 1 hour at each place (30–60 min).
  /// 3. LEISURELY: Spend MORE THAN 1 hour at each place (65–90 min).
  static int getVisitDurationMinutes(String placeId, String tempo, int index) {
    final pace = tempo.trim().toLowerCase();
    final normId = placeId.trim().toLowerCase().replaceAll('-', '_');

    if (pace.contains('quick')) {
      // Anuradhapura
      if (normId.contains('ruwanweli')) return 25;
      if (normId.contains('maha_bodhi') || normId.contains('bodhi')) return 20;
      if (normId.contains('thuparamaya')) return 28;
      if (normId.contains('jetavana')) return 24;
      if (normId.contains('abhayagiri')) return 26;
      // Polonnaruwa
      if (normId.contains('gal_viharaya')) return 25;
      if (normId.contains('royal_palace')) return 20;
      if (normId.contains('rankoth')) return 28;
      if (normId.contains('lankathilaka')) return 22;
      if (normId.contains('parakrama')) return 26;
      // Dambulla
      if (normId.contains('dambulla')) return 25;
      if (normId.contains('sigiriya')) return 28;
      if (normId.contains('ibbankatuwa')) return 20;
      // Down South
      if (normId.contains('galle')) return 28;
      if (normId.contains('star_fort')) return 22;
      if (normId.contains('mulgirigala')) return 26;
      if (normId.contains('kushta_raja')) return 18;

      final variations = [25, 20, 28, 24, 26, 22, 18];
      return variations[index % variations.length];
    } else if (pace.contains('leisurely')) {
      // Anuradhapura
      if (normId.contains('ruwanweli')) return 75; // 1h 15m
      if (normId.contains('maha_bodhi') || normId.contains('bodhi')) return 70; // 1h 10m
      if (normId.contains('thuparamaya')) return 80; // 1h 20m
      if (normId.contains('jetavana')) return 85; // 1h 25m
      if (normId.contains('abhayagiri')) return 90; // 1h 30m
      // Polonnaruwa
      if (normId.contains('gal_viharaya')) return 75; // 1h 15m
      if (normId.contains('royal_palace')) return 70; // 1h 10m
      if (normId.contains('rankoth')) return 80; // 1h 20m
      if (normId.contains('lankathilaka')) return 65; // 1h 05m
      if (normId.contains('parakrama')) return 85; // 1h 25m
      // Dambulla
      if (normId.contains('dambulla')) return 75; // 1h 15m
      if (normId.contains('sigiriya')) return 90; // 1h 30m
      if (normId.contains('ibbankatuwa')) return 70; // 1h 10m
      // Down South
      if (normId.contains('galle')) return 90; // 1h 30m
      if (normId.contains('star_fort')) return 70; // 1h 10m
      if (normId.contains('mulgirigala')) return 80; // 1h 20m
      if (normId.contains('kushta_raja')) return 65; // 1h 05m

      final variations = [75, 70, 80, 85, 90, 65];
      return variations[index % variations.length];
    } else {
      // Default: MODERATE (30-60 min)
      // Anuradhapura
      if (normId.contains('ruwanweli')) return 50;
      if (normId.contains('maha_bodhi') || normId.contains('bodhi')) return 45;
      if (normId.contains('thuparamaya')) return 40;
      if (normId.contains('jetavana')) return 50;
      if (normId.contains('abhayagiri')) return 55;
      // Polonnaruwa
      if (normId.contains('gal_viharaya')) return 45;
      if (normId.contains('royal_palace')) return 40;
      if (normId.contains('rankoth')) return 50;
      if (normId.contains('lankathilaka')) return 35;
      if (normId.contains('parakrama')) return 45;
      // Dambulla
      if (normId.contains('dambulla')) return 50;
      if (normId.contains('sigiriya')) return 60;
      if (normId.contains('ibbankatuwa')) return 40;
      // Down South
      if (normId.contains('galle')) return 60;
      if (normId.contains('star_fort')) return 40;
      if (normId.contains('mulgirigala')) return 50;
      if (normId.contains('kushta_raja')) return 35;

      final variations = [50, 45, 40, 50, 55, 35];
      return variations[index % variations.length];
    }
  }

  /// Formats visit duration label:
  /// - Less than 60m: e.g. "25m", "50m"
  /// - 60m or more: e.g. "1h 15m", "1h 10m", "1h 05m", "1h 30m"
  static String formatStayDuration(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    } else {
      final h = minutes ~/ 60;
      final m = minutes % 60;
      if (m == 0) return '${h}h';
      return '${h}h ${m.toString().padLeft(2, '0')}m';
    }
  }

  /// BREAK RULE:
  /// After every 4 selected places:
  /// - Quick → 30 min break
  /// - Moderate → 50 min break
  /// - Leisurely → 1 hour break (60 min)
  static int getBreakMinutes(String tempo) {
    final pace = tempo.trim().toLowerCase();
    if (pace.contains('quick')) {
      return 30;
    } else if (pace.contains('leisurely')) {
      return 60;
    } else {
      return 50;
    }
  }

  /// Parses the available time string into total active touring minutes.
  static int parseAvailableMinutes(String timeStr) {
    final s = timeStr.trim().toLowerCase();
    final matchH = RegExp(r'(\d+)\s*h').firstMatch(s);
    if (matchH != null) {
      return int.parse(matchH.group(1)!) * 60;
    }
    final matchDay = RegExp(r'(\d+)\s*day').firstMatch(s);
    if (matchDay != null) {
      final days = int.parse(matchDay.group(1)!);
      return days * 8 * 60; // 8 active sightseeing hours per day
    }
    return 480; // default: 8 hours = 480 minutes
  }

  /// Haversine distance in kilometers between two lat/lng coordinates.
  static double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // Math.PI / 180
    final a = 0.5 -
        math.cos((lat2 - lat1) * p) / 2 +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - lon1) * p)) /
            2;
    return 12742 * math.asin(math.sqrt(a)); // 2 * R; R = 6371 km
  }

  /// Standard leg distances & walking durations between places.
  static ({double km, int minutes}) getLegInfo(
    String fromId,
    String toId,
    String tempo, {
    HistoricalPlace? fromPlace,
    HistoricalPlace? toPlace,
  }) {
    final fromNorm = fromId.trim().toLowerCase().replaceAll('-', '_');
    final toNorm = toId.trim().toLowerCase().replaceAll('-', '_');

    final Map<String, Map<String, ({double km, int minutes})>> table = {
      // ANURADHAPURA
      'ruwanwelisaya': {
        'sri_maha_bodhi': (km: 0.85, minutes: 12),
        'thuparamaya': (km: 1.2, minutes: 15),
        'jetavanaramaya': (km: 2.0, minutes: 24),
        'abhayagiri': (km: 2.8, minutes: 34),
      },
      'sri_maha_bodhi': {
        'ruwanwelisaya': (km: 0.85, minutes: 12),
        'thuparamaya': (km: 1.0, minutes: 10),
        'jetavanaramaya': (km: 1.8, minutes: 22),
        'abhayagiri': (km: 3.5, minutes: 42),
      },
      'thuparamaya': {
        'jetavanaramaya': (km: 1.6, minutes: 18),
        'abhayagiri': (km: 2.4, minutes: 28),
        'ruwanwelisaya': (km: 1.2, minutes: 15),
        'sri_maha_bodhi': (km: 1.0, minutes: 10),
      },
      'jetavanaramaya': {
        'abhayagiri': (km: 2.2, minutes: 25),
        'thuparamaya': (km: 1.6, minutes: 18),
        'ruwanwelisaya': (km: 2.0, minutes: 24),
        'sri_maha_bodhi': (km: 1.8, minutes: 22),
      },
      'abhayagiri': {
        'jetavanaramaya': (km: 2.2, minutes: 25),
        'thuparamaya': (km: 2.4, minutes: 28),
        'ruwanwelisaya': (km: 2.8, minutes: 34),
        'sri_maha_bodhi': (km: 3.5, minutes: 42),
      },

      // POLONNARUWA
      'gal_viharaya': {
        'royal_palace': (km: 2.7, minutes: 33),
        'rankoth_vehera': (km: 1.2, minutes: 15),
        'lankathilaka': (km: 0.6, minutes: 8),
        'lankathilaka_image_house': (km: 0.6, minutes: 8),
        'parakrama_samudraya': (km: 5.3, minutes: 65),
      },
      'royal_palace': {
        'gal_viharaya': (km: 2.7, minutes: 33),
        'rankoth_vehera': (km: 1.6, minutes: 20),
        'lankathilaka': (km: 2.2, minutes: 27),
        'lankathilaka_image_house': (km: 2.2, minutes: 27),
        'parakrama_samudraya': (km: 3.0, minutes: 38),
      },
      'rankoth_vehera': {
        'gal_viharaya': (km: 1.2, minutes: 15),
        'royal_palace': (km: 1.6, minutes: 20),
        'lankathilaka': (km: 0.7, minutes: 9),
        'lankathilaka_image_house': (km: 0.7, minutes: 9),
        'parakrama_samudraya': (km: 4.3, minutes: 53),
      },
      'lankathilaka': {
        'gal_viharaya': (km: 0.6, minutes: 8),
        'royal_palace': (km: 2.2, minutes: 27),
        'rankoth_vehera': (km: 0.7, minutes: 9),
        'parakrama_samudraya': (km: 4.9, minutes: 60),
      },
      'lankathilaka_image_house': {
        'gal_viharaya': (km: 0.6, minutes: 8),
        'royal_palace': (km: 2.2, minutes: 27),
        'rankoth_vehera': (km: 0.7, minutes: 9),
        'parakrama_samudraya': (km: 4.9, minutes: 60),
      },
      'parakrama_samudraya': {
        'gal_viharaya': (km: 5.3, minutes: 65),
        'royal_palace': (km: 3.0, minutes: 38),
        'rankoth_vehera': (km: 4.3, minutes: 53),
        'lankathilaka': (km: 4.9, minutes: 60),
        'lankathilaka_image_house': (km: 4.9, minutes: 60),
      },

      // DAMBULLA
      'dambulla_cave_temple': {
        'ibbankatuwa_megalithic_tombs': (km: 4.5, minutes: 55),
        'ibbankatuwa': (km: 4.5, minutes: 55),
        'sigiriya_rock_fortress': (km: 17.5, minutes: 210),
        'sigiriya': (km: 17.5, minutes: 210),
      },
      'dambulla': {
        'ibbankatuwa_megalithic_tombs': (km: 4.5, minutes: 55),
        'ibbankatuwa': (km: 4.5, minutes: 55),
        'sigiriya_rock_fortress': (km: 17.5, minutes: 210),
        'sigiriya': (km: 17.5, minutes: 210),
      },
      'sigiriya_rock_fortress': {
        'dambulla_cave_temple': (km: 17.5, minutes: 210),
        'dambulla': (km: 17.5, minutes: 210),
        'ibbankatuwa_megalithic_tombs': (km: 21.0, minutes: 255),
        'ibbankatuwa': (km: 21.0, minutes: 255),
      },
      'sigiriya': {
        'dambulla_cave_temple': (km: 17.5, minutes: 210),
        'dambulla': (km: 17.5, minutes: 210),
        'ibbankatuwa_megalithic_tombs': (km: 21.0, minutes: 255),
        'ibbankatuwa': (km: 21.0, minutes: 255),
      },
      'ibbankatuwa_megalithic_tombs': {
        'dambulla_cave_temple': (km: 4.5, minutes: 55),
        'dambulla': (km: 4.5, minutes: 55),
        'sigiriya_rock_fortress': (km: 21.0, minutes: 255),
        'sigiriya': (km: 21.0, minutes: 255),
      },
      'ibbankatuwa': {
        'dambulla_cave_temple': (km: 4.5, minutes: 55),
        'dambulla': (km: 4.5, minutes: 55),
        'sigiriya_rock_fortress': (km: 21.0, minutes: 255),
        'sigiriya': (km: 21.0, minutes: 255),
      },

      // DOWN SOUTH
      'galle_dutch_fort_lighthouse': {
        'kushta_raja_gala': (km: 3.5, minutes: 45),
        'kushta_raja': (km: 3.5, minutes: 45),
        'star_fort_matara': (km: 6.0, minutes: 75),
        'star_fort': (km: 6.0, minutes: 75),
        'mulgirigala_rock_temple': (km: 9.0, minutes: 110),
        'mulgirigala': (km: 9.0, minutes: 110),
      },
      'kushta_raja_gala': {
        'galle_dutch_fort_lighthouse': (km: 3.5, minutes: 45),
        'galle': (km: 3.5, minutes: 45),
        'star_fort_matara': (km: 2.8, minutes: 35),
        'star_fort': (km: 2.8, minutes: 35),
        'mulgirigala_rock_temple': (km: 6.5, minutes: 80),
        'mulgirigala': (km: 6.5, minutes: 80),
      },
      'star_fort_matara': {
        'galle_dutch_fort_lighthouse': (km: 6.0, minutes: 75),
        'galle': (km: 6.0, minutes: 75),
        'kushta_raja_gala': (km: 2.8, minutes: 35),
        'kushta_raja': (km: 2.8, minutes: 35),
        'mulgirigala_rock_temple': (km: 4.0, minutes: 50),
        'mulgirigala': (km: 4.0, minutes: 50),
      },
      'mulgirigala_rock_temple': {
        'galle_dutch_fort_lighthouse': (km: 9.0, minutes: 110),
        'galle': (km: 9.0, minutes: 110),
        'kushta_raja_gala': (km: 6.5, minutes: 80),
        'kushta_raja': (km: 6.5, minutes: 80),
        'star_fort_matara': (km: 4.0, minutes: 50),
        'star_fort': (km: 4.0, minutes: 50),
      },
    };

    final leg = table[fromNorm]?[toNorm] ??
        table[toNorm]?[fromNorm];

    if (leg != null) {
      return leg;
    }

    // Dynamic Haversine calculation if coordinates are available
    if (fromPlace != null && toPlace != null) {
      final distKm = _haversineKm(fromPlace.lat, fromPlace.lng, toPlace.lat, toPlace.lng);
      final walkMins = (distKm / 4.5 * 60).round().clamp(2, 180);
      return (km: double.parse(distKm.toStringAsFixed(1)), minutes: walkMins);
    }

    return (km: 1.0, minutes: 12);
  }

  /// Route-generation algorithm:
  /// Takes the filtered, eligible places and calculates:
  /// - Automatic fitting of places based on available time & pace
  /// - Visit duration per place (Quick <30m, Moderate 30-60m, Leisurely >1h)
  /// - Walking time between places
  /// - Break time after every 4 places
  /// - Timeline arrival and departure times starting at 09:00 AM
  /// - Total tour duration and total distance
  static GeneratedWalkingTour buildTourRoute({
    required List<FilteredPlace> eligiblePlaces,
    required String tempo,
    required String timeAvailable,
    required String ratingFilter,
    required String destinationName,
  }) {
    final circuitTitle = destinationName.toLowerCase().contains('polonnaruwa')
        ? 'POLONNARUWA · HISTORICAL CIRCUIT'
        : destinationName.toLowerCase().contains('dambulla')
            ? 'DAMBULLA · HISTORICAL CIRCUIT'
            : destinationName.toLowerCase().contains('south')
                ? 'DOWN SOUTH · HISTORICAL CIRCUIT'
                : 'CURATED HISTORICAL CIRCUIT';

    final headline = _formatTourHeadline(destinationName, timeAvailable);

    if (eligiblePlaces.isEmpty) {
      return GeneratedWalkingTour(
        destinationName: destinationName,
        circuitTitle: circuitTitle,
        headline: headline,
        description:
            'No places currently meet the selected minimum rating ($ratingFilter).',
        totalDurationLabel: '0h 0m',
        totalDistanceLabel: '0.0 km',
        totalVisitTimeLabel: '0m',
        totalWalkTimeLabel: '0m',
        totalBreakTimeLabel: '0m',
        totalVisitMinutes: 0,
        totalWalkMinutes: 0,
        totalBreakMinutes: 0,
        tempo: tempo,
        timeAvailable: timeAvailable,
        ratingFilter: ratingFilter,
        stops: const [],
      );
    }

    final int availableMinutes = parseAvailableMinutes(timeAvailable);

    // DYNAMIC CAPACITY CALCULATION:
    // Number of places is NOT hardcoded.
    // It is calculated from: visit duration + walking time + break time.
    final List<FilteredPlace> fittedPlaces = [];
    int simulatedMinutes = 0;

    for (int i = 0; i < eligiblePlaces.length; i++) {
      final currentPlace = eligiblePlaces[i];
      final visitMin = getVisitDurationMinutes(currentPlace.placeId, tempo, i);

      int transitionMin = 0;
      if (fittedPlaces.isNotEmpty) {
        final prevPlace = fittedPlaces.last;
        final leg = getLegInfo(
          prevPlace.placeId,
          currentPlace.placeId,
          tempo,
          fromPlace: prevPlace.place,
          toPlace: currentPlace.place,
        );
        transitionMin = leg.minutes;

        // Apply Break Rule: after every 4 selected places
        if (fittedPlaces.length % 4 == 0) {
          transitionMin += getBreakMinutes(tempo);
        }
      }

      final potentialTotal = simulatedMinutes + transitionMin + visitMin;

      // Always include at least the first 2 places if available,
      // and only add additional places if they fit within availableMinutes budget.
      if (fittedPlaces.length < 2 || potentialTotal <= availableMinutes) {
        fittedPlaces.add(currentPlace);
        simulatedMinutes = potentialTotal;
      } else {
        // Exceeds available time budget; stop adding places
        break;
      }
    }

    // Start tour at 09:00 AM (09:00 = 540 minutes from midnight)
    int currentMinutesFromMidnight = 9 * 60;
    double accumulatedDistanceKm = 0.0;
    int accumulatedVisitMinutes = 0;
    int accumulatedWalkMinutes = 0;
    int accumulatedBreakMinutes = 0;

    final List<WalkingRouteStop> routeStops = [];

    for (int i = 0; i < fittedPlaces.length; i++) {
      final current = fittedPlaces[i];
      final pId = current.placeId;

      final stay = getVisitDurationMinutes(pId, tempo, i);
      accumulatedVisitMinutes += stay;

      final arrivalTimeStr = _formatMinutesToAmPm(currentMinutesFromMidnight);

      currentMinutesFromMidnight += stay;
      final departureTimeStr = _formatMinutesToAmPm(currentMinutesFromMidnight);

      double distanceToNext = 0.0;
      int walkMinutesToNext = 0;
      bool hasBreakAfter = false;
      int breakMinutesAfter = 0;

      if (i < fittedPlaces.length - 1) {
        final next = fittedPlaces[i + 1];
        final legInfo = getLegInfo(
          pId,
          next.placeId,
          tempo,
          fromPlace: current.place,
          toPlace: next.place,
        );

        distanceToNext = legInfo.km;
        walkMinutesToNext = legInfo.minutes;
        accumulatedWalkMinutes += walkMinutesToNext;

        // Apply Break Rule after every 4 selected places (index 3, 7...)
        if ((i + 1) % 4 == 0) {
          hasBreakAfter = true;
          breakMinutesAfter = getBreakMinutes(tempo);
          accumulatedBreakMinutes += breakMinutesAfter;
        }

        // Timeline advances: departure + walk time + break time
        currentMinutesFromMidnight += (walkMinutesToNext + breakMinutesAfter);
        accumulatedDistanceKm += distanceToNext;
      }

      final distLabel = distanceToNext < 1.0
          ? '${(distanceToNext * 1000).round()} m'
          : '${distanceToNext.toStringAsFixed(1)} km';
      final walkLabel = '$walkMinutesToNext min walk';

      routeStops.add(
        WalkingRouteStop(
          stepNumber: i + 1,
          place: current.place,
          realAverageRating: current.realAverageRating,
          reviewCount: current.reviewCount,
          arrivalTime: arrivalTimeStr,
          departureTime: departureTimeStr,
          stayDurationMinutes: stay,
          stayDurationLabel: formatStayDuration(stay),
          distanceToNextKm: distanceToNext,
          distanceToNextLabel: distLabel,
          walkMinutesToNext: walkMinutesToNext,
          walkTimeToNextLabel: walkLabel,
          hasBreakAfter: hasBreakAfter,
          breakMinutesAfter: breakMinutesAfter,
        ),
      );
    }

    // Total route time calculation (elapsed minutes from start to finish)
    final totalTripMinutes = currentMinutesFromMidnight - (9 * 60);
    final totalHours = totalTripMinutes ~/ 60;
    final totalRemMins = totalTripMinutes % 60;
    final totalDurationStr = totalRemMins == 0
        ? '${totalHours}h 0m'
        : '${totalHours}h ${totalRemMins}m';

    final totalDistanceStr = accumulatedDistanceKm > 0.0
        ? '${accumulatedDistanceKm.toStringAsFixed(1)} km'
        : '0.0 km';

    final desc = destinationName.toLowerCase().contains('polonnaruwa')
        ? 'A personalized journey exploring the ancient ruins, grand palaces, and sacred stupas of Polonnaruwa.'
        : destinationName.toLowerCase().contains('dambulla')
            ? 'A personalized journey through the ancient rock temples, fortress ruins, and prehistoric heritage of Dambulla.'
            : destinationName.toLowerCase().contains('south')
                ? 'A scenic coastal journey through the colonial fortresses, sacred rock temples, and historic ruins of Down South.'
                : 'A perfect blend of history, culture and peaceful sacred moments.';

    return GeneratedWalkingTour(
      destinationName: destinationName,
      circuitTitle: circuitTitle,
      headline: headline,
      description: desc,
      totalDurationLabel: totalDurationStr,
      totalDistanceLabel: totalDistanceStr,
      totalVisitTimeLabel: formatStayDuration(accumulatedVisitMinutes),
      totalWalkTimeLabel: formatStayDuration(accumulatedWalkMinutes),
      totalBreakTimeLabel: accumulatedBreakMinutes > 0
          ? formatStayDuration(accumulatedBreakMinutes)
          : '0m',
      totalVisitMinutes: accumulatedVisitMinutes,
      totalWalkMinutes: accumulatedWalkMinutes,
      totalBreakMinutes: accumulatedBreakMinutes,
      tempo: tempo,
      timeAvailable: timeAvailable,
      ratingFilter: ratingFilter,
      stops: routeStops,
    );
  }

  static String _formatTourHeadline(String destinationName, String timeAvailable) {
    final t = timeAvailable.trim();
    final isPol = destinationName.toLowerCase().contains('polonnaruwa');
    final isDam = destinationName.toLowerCase().contains('dambulla');
    final isSouth = destinationName.toLowerCase().contains('south');
    final cityPrefix = isPol
        ? 'Polonnaruwa '
        : (isDam
            ? 'Dambulla '
            : (isSouth
                ? 'Down South '
                : ''));

    if (t.contains('8h')) return 'Your 8-Hour ${cityPrefix}Walking Tour';
    if (t.contains('12h')) return 'Your 12-Hour ${cityPrefix}Walking Tour';
    if (t.contains('1 Day')) return 'Your 1-Day ${cityPrefix}Walking Tour';
    if (t.contains('2 Day')) return 'Your 2-Day ${cityPrefix}Walking Tour';
    return 'Your $t ${cityPrefix}Walking Tour';
  }

  static String _formatMinutesToAmPm(int totalMinutes) {
    final hours24 = (totalMinutes ~/ 60) % 24;
    final mins = totalMinutes % 60;
    final isPm = hours24 >= 12;
    final hours12 = hours24 == 0 ? 12 : (hours24 > 12 ? hours24 - 12 : hours24);
    final minsStr = mins.toString().padLeft(2, '0');
    final period = isPm ? 'PM' : 'AM';
    return '$hours12:$minsStr $period';
  }
}
