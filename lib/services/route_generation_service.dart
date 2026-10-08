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
  final String tempo;
  final String ratingFilter;
  final List<WalkingRouteStop> stops;

  const GeneratedWalkingTour({
    required this.destinationName,
    required this.circuitTitle,
    required this.headline,
    required this.description,
    required this.totalDurationLabel,
    required this.totalDistanceLabel,
    required this.tempo,
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
  ///    - 1 Star → average rating >= 1.0
  ///    - 2 Star → average rating >= 2.0
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
        return item.realAverageRating >= 1.0;
      } else if (ratingFilter == '2 Star') {
        return item.realAverageRating >= 2.0;
      }
      return true;
    }).toList();
  }

  /// Calculates the realistic visit duration for a place based strictly on pace:
  ///
  /// 1. QUICK: Spend LESS THAN 30 minutes at each place (15–29 min).
  ///    Examples: Ruwanwelisaya → 25 min, Sri Maha Bodhi → 20 min, Next place → 28 min.
  /// 2. MODERATE: Spend BETWEEN 30 minutes and 1 hour at each place (30–60 min).
  ///    Examples: Ruwanwelisaya → 50 min, Sri Maha Bodhi → 45 min, Next place → 40 min.
  /// 3. LEISURELY: Spend MORE THAN 1 hour at each place (60–90 min).
  ///    Examples: Ruwanwelisaya → 75 min (1h 15m), Sri Maha Bodhi → 70 min (1h 10m), Next place → 80 min (1h 20m).
  static int getVisitDurationMinutes(String placeId, String tempo, int index) {
    final pace = tempo.trim().toLowerCase();
    final normId = placeId.trim().toLowerCase().replaceAll('-', '_');

    if (pace.contains('quick')) {
      if (normId.contains('ruwanweli')) return 25;
      if (normId.contains('maha_bodhi') || normId.contains('bodhi')) return 20;
      if (normId.contains('thuparamaya')) return 28;
      if (normId.contains('jetavana')) return 24;
      if (normId.contains('abhayagiri')) return 26;
      final variations = [25, 20, 28, 24, 26, 22, 18];
      return variations[index % variations.length];
    } else if (pace.contains('leisurely')) {
      if (normId.contains('ruwanweli')) return 75; // 1h 15m
      if (normId.contains('maha_bodhi') || normId.contains('bodhi')) return 70; // 1h 10m
      if (normId.contains('thuparamaya')) return 80; // 1h 20m
      if (normId.contains('jetavana')) return 85; // 1h 25m
      if (normId.contains('abhayagiri')) return 90; // 1h 30m
      final variations = [75, 70, 80, 85, 90, 65];
      return variations[index % variations.length];
    } else {
      // Default: MODERATE (30-60 min)
      if (normId.contains('ruwanweli')) return 50;
      if (normId.contains('maha_bodhi') || normId.contains('bodhi')) return 45;
      if (normId.contains('thuparamaya')) return 40;
      if (normId.contains('jetavana')) return 50;
      if (normId.contains('abhayagiri')) return 55;
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

  /// Parses the available time string into total minutes.
  static int parseAvailableMinutes(String timeStr) {
    final s = timeStr.trim().toLowerCase();
    final matchH = RegExp(r'(\d+)\s*h').firstMatch(s);
    if (matchH != null) {
      return int.parse(matchH.group(1)!) * 60;
    }
    final matchDay = RegExp(r'(\d+)\s*day').firstMatch(s);
    if (matchDay != null) {
      return int.parse(matchDay.group(1)!) * 8 * 60; // 8 active tour hours per day
    }
    return 480; // default: 8 hours = 480 minutes
  }

  /// Standard leg distances & walking durations between places.
  static ({double km, int minutes}) getLegInfo(
    String fromId,
    String toId,
    String tempo,
  ) {
    final fromNorm = fromId.trim().toLowerCase().replaceAll('-', '_');
    final toNorm = toId.trim().toLowerCase().replaceAll('-', '_');

    final Map<String, Map<String, ({double km, int minutes})>> table = {
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
    };

    final leg = table[fromNorm]?[toNorm] ??
        table[toNorm]?[fromNorm] ??
        (km: 1.0, minutes: 12);

    return leg;
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
    if (eligiblePlaces.isEmpty) {
      return GeneratedWalkingTour(
        destinationName: destinationName,
        circuitTitle: 'CURATED HISTORICAL CIRCUIT',
        headline: _formatTourHeadline(timeAvailable),
        description:
            'No places currently meet the selected minimum rating ($ratingFilter).',
        totalDurationLabel: '0h 0m',
        totalDistanceLabel: '0.0 km',
        tempo: tempo,
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
        final leg = getLegInfo(prevPlace.placeId, currentPlace.placeId, tempo);
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
    final List<WalkingRouteStop> routeStops = [];

    for (int i = 0; i < fittedPlaces.length; i++) {
      final current = fittedPlaces[i];
      final pId = current.placeId;

      final stay = getVisitDurationMinutes(pId, tempo, i);
      final arrivalTimeStr = _formatMinutesToAmPm(currentMinutesFromMidnight);

      currentMinutesFromMidnight += stay;
      final departureTimeStr = _formatMinutesToAmPm(currentMinutesFromMidnight);

      double distanceToNext = 0.0;
      int walkMinutesToNext = 0;
      bool hasBreakAfter = false;
      int breakMinutesAfter = 0;

      if (i < fittedPlaces.length - 1) {
        final next = fittedPlaces[i + 1];
        final legInfo = getLegInfo(pId, next.placeId, tempo);

        distanceToNext = legInfo.km;
        walkMinutesToNext = legInfo.minutes;

        // Apply Break Rule after every 4 selected places (index 3, 7...)
        if ((i + 1) % 4 == 0) {
          hasBreakAfter = true;
          breakMinutesAfter = getBreakMinutes(tempo);
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

    return GeneratedWalkingTour(
      destinationName: destinationName,
      circuitTitle: 'CURATED HISTORICAL CIRCUIT',
      headline: _formatTourHeadline(timeAvailable),
      description:
          'A perfect blend of history, culture and peaceful sacred moments.',
      totalDurationLabel: totalDurationStr,
      totalDistanceLabel: totalDistanceStr,
      tempo: tempo,
      ratingFilter: ratingFilter,
      stops: routeStops,
    );
  }

  static String _formatTourHeadline(String timeAvailable) {
    final t = timeAvailable.trim();
    if (t.contains('8h')) return 'Your 8-Hour Walking Tour';
    if (t.contains('12h')) return 'Your 12-Hour Walking Tour';
    if (t.contains('1 Day')) return 'Your 1-Day Walking Tour';
    if (t.contains('2 Day')) return 'Your 2-Day Walking Tour';
    return 'Your $t Walking Tour';
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
