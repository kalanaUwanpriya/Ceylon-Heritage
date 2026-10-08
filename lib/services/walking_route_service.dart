import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'open_route_service_config.dart';

/// Result object returned by [WalkingRouteService].
class WalkingRouteResult {
  final List<LatLng> points;
  final double totalDistanceMeters;
  final double totalDurationSeconds;
  final bool isSuccessful;
  final String? errorMessage;

  const WalkingRouteResult({
    required this.points,
    this.totalDistanceMeters = 0.0,
    this.totalDurationSeconds = 0.0,
    required this.isSuccessful,
    this.errorMessage,
  });

  bool get hasPoints => points.isNotEmpty;

  static const WalkingRouteResult empty = WalkingRouteResult(
    points: [],
    isSuccessful: false,
    errorMessage: 'No route coordinates provided',
  );
}

/// Service responsible for fetching real pedestrian/walking paths from OpenRouteService.
///
/// Responsibilities:
/// - Accept a list of coordinates (LatLng).
/// - Request real walking routes from OpenRouteService foot-walking API.
/// - Parse the returned GeoJSON route geometry into [List<LatLng>].
/// - Sequentially process pairs if needed to preserve tour order.
/// - Cache routes to prevent repeated API requests on rebuild.
/// - Gracefully handle API errors, network issues, timeouts, and rate limits.
class WalkingRouteService {
  final http.Client _client;

  // In-memory cache to avoid repeated API requests
  static final Map<String, WalkingRouteResult> _cache = {};

  WalkingRouteService({http.Client? client}) : _client = client ?? http.Client();

  /// Generates a walking route connecting the given [waypoints] in order.
  Future<WalkingRouteResult> getWalkingRoute(
    List<LatLng> waypoints, {
    bool forceRefresh = false,
  }) async {
    if (waypoints.length < 2) {
      if (waypoints.length == 1) {
        return WalkingRouteResult(
          points: [waypoints.first],
          isSuccessful: true,
        );
      }
      return WalkingRouteResult.empty;
    }

    final cacheKey = _createCacheKey(waypoints);
    if (!forceRefresh && _cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      // 1. First attempt: Complete multi-waypoint walking route request
      final multiResult = await _fetchMultiWaypointRoute(waypoints);
      if (multiResult.isSuccessful && multiResult.hasPoints) {
        _cache[cacheKey] = multiResult;
        return multiResult;
      }

      // 2. Fallback: Sequential pairwise segments (Place 1 -> 2, Place 2 -> 3...)
      final sequentialResult = await _fetchSequentialPairwiseRoute(waypoints);
      _cache[cacheKey] = sequentialResult;
      return sequentialResult;
    } catch (e) {
      return WalkingRouteResult(
        points: const [],
        isSuccessful: false,
        errorMessage: 'Unable to reach routing service: ${e.toString()}',
      );
    }
  }

  /// Request multi-waypoint walking directions in a single API call.
  Future<WalkingRouteResult> _fetchMultiWaypointRoute(
      List<LatLng> waypoints) async {
    final url = Uri.parse(OpenRouteServiceConfig.footWalkingUrl);

    // OpenRouteService expects coordinates as [longitude, latitude]
    final coordinatesList =
        waypoints.map((p) => [p.longitude, p.latitude]).toList();

    final body = jsonEncode({
      'coordinates': coordinatesList,
      'instructions': false,
      'elevation': false,
    });

    final response = await _client
        .post(
          url,
          headers: {
            'Authorization': OpenRouteServiceConfig.apiKey,
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json, application/geo+json',
          },
          body: body,
        )
        .timeout(const Duration(seconds: 12));

    if (response.statusCode == 200) {
      return _parseGeoJsonResponse(response.body);
    } else {
      final errorMsg = _parseErrorMessage(response.statusCode, response.body);
      return WalkingRouteResult(
        points: const [],
        isSuccessful: false,
        errorMessage: errorMsg,
      );
    }
  }

  /// Fetches routes for consecutive pairs Place 1 -> 2, Place 2 -> 3, etc.
  Future<WalkingRouteResult> _fetchSequentialPairwiseRoute(
      List<LatLng> waypoints) async {
    final List<LatLng> combinedPoints = [];
    double totalDistance = 0.0;
    double totalDuration = 0.0;
    String? lastError;

    for (int i = 0; i < waypoints.length - 1; i++) {
      final start = waypoints[i];
      final end = waypoints[i + 1];

      try {
        final pairResult = await _fetchPairRoute(start, end);
        if (pairResult.isSuccessful && pairResult.hasPoints) {
          combinedPoints.addAll(pairResult.points);
          totalDistance += pairResult.totalDistanceMeters;
          totalDuration += pairResult.totalDurationSeconds;
        } else {
          lastError = pairResult.errorMessage;
        }
      } catch (e) {
        lastError = e.toString();
      }
    }

    if (combinedPoints.isNotEmpty) {
      return WalkingRouteResult(
        points: combinedPoints,
        totalDistanceMeters: totalDistance,
        totalDurationSeconds: totalDuration,
        isSuccessful: true,
        errorMessage: lastError,
      );
    }

    return WalkingRouteResult(
      points: const [],
      isSuccessful: false,
      errorMessage: lastError ?? 'Walking route could not be calculated',
    );
  }

  /// Fetch walking route between two points.
  Future<WalkingRouteResult> _fetchPairRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(OpenRouteServiceConfig.footWalkingUrl);
    final body = jsonEncode({
      'coordinates': [
        [start.longitude, start.latitude],
        [end.longitude, end.latitude],
      ],
      'instructions': false,
    });

    final response = await _client
        .post(
          url,
          headers: {
            'Authorization': OpenRouteServiceConfig.apiKey,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return _parseGeoJsonResponse(response.body);
    } else {
      return WalkingRouteResult(
        points: const [],
        isSuccessful: false,
        errorMessage: _parseErrorMessage(response.statusCode, response.body),
      );
    }
  }

  /// Parses OpenRouteService GeoJSON FeatureCollection response.
  static WalkingRouteResult _parseGeoJsonResponse(String responseBody) {
    try {
      final data = jsonDecode(responseBody) as Map<String, dynamic>;
      final features = data['features'] as List<dynamic>?;

      if (features == null || features.isEmpty) {
        return const WalkingRouteResult(
          points: [],
          isSuccessful: false,
          errorMessage: 'No route geometry returned',
        );
      }

      final feature = features.first as Map<String, dynamic>;
      final geometry = feature['geometry'] as Map<String, dynamic>?;
      final rawCoords = geometry?['coordinates'] as List<dynamic>?;

      if (rawCoords == null || rawCoords.isEmpty) {
        return const WalkingRouteResult(
          points: [],
          isSuccessful: false,
          errorMessage: 'Empty coordinates in route geometry',
        );
      }

      final List<LatLng> latLngList = [];
      for (final item in rawCoords) {
        if (item is List && item.length >= 2) {
          final lng = (item[0] as num).toDouble();
          final lat = (item[1] as num).toDouble();
          latLngList.add(LatLng(lat, lng));
        }
      }

      final properties = feature['properties'] as Map<String, dynamic>?;
      final summary = properties?['summary'] as Map<String, dynamic>?;
      final distance = (summary?['distance'] as num?)?.toDouble() ?? 0.0;
      final duration = (summary?['duration'] as num?)?.toDouble() ?? 0.0;

      return WalkingRouteResult(
        points: latLngList,
        totalDistanceMeters: distance,
        totalDurationSeconds: duration,
        isSuccessful: true,
      );
    } catch (e) {
      return WalkingRouteResult(
        points: const [],
        isSuccessful: false,
        errorMessage: 'Failed to parse route data: $e',
      );
    }
  }

  static String _parseErrorMessage(int statusCode, String body) {
    if (statusCode == 401 || statusCode == 403) {
      return 'Authentication failed with OpenRouteService. Check API key.';
    } else if (statusCode == 429) {
      return 'Rate limit exceeded for walking directions. Try again shortly.';
    } else if (statusCode == 404 || statusCode == 400) {
      return 'No pedestrian walking path available between these locations.';
    }
    return 'Routing service returned status code $statusCode.';
  }

  static String _createCacheKey(List<LatLng> waypoints) {
    return waypoints
        .map((p) =>
            '${p.latitude.toStringAsFixed(5)},${p.longitude.toStringAsFixed(5)}')
        .join('|');
  }

  /// Clears in-memory route cache if required
  static void clearCache() {
    _cache.clear();
  }
}
