import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';
import 'package:ceylon_heritage/models/historical_place.dart';
import 'package:ceylon_heritage/services/open_route_service_config.dart';
import 'package:ceylon_heritage/services/walking_route_service.dart';

void main() {
  group('WalkingRouteService & OpenRouteService Integration Tests', () {
    setUp(() {
      WalkingRouteService.clearCache();
    });

    test('OpenRouteServiceConfig stores and updates API key without committing directly in UI', () {
      final initialKey = OpenRouteServiceConfig.apiKey;
      expect(initialKey, isNotEmpty);

      OpenRouteServiceConfig.setApiKey('test_custom_api_key_123');
      expect(OpenRouteServiceConfig.apiKey, 'test_custom_api_key_123');

      // Reset
      OpenRouteServiceConfig.setApiKey(initialKey);
    });

    test('HistoricalPlace contains real coordinates and category', () {
      final ruwanwelisaya = HistoricalPlace(
        name: 'Ruwanwelisaya',
        destination: 'Anuradhapura',
        description: 'Great stupa',
        location: 'Anuradhapura',
        image: 'assets/images/anuradhapura.png',
      );

      expect(ruwanwelisaya.placeCategory, 'Historical Site');
      expect(ruwanwelisaya.lat, closeTo(8.3500, 0.01));
      expect(ruwanwelisaya.lng, closeTo(80.3962, 0.01));

      final sriMahaBodhi = HistoricalPlace(
        name: 'Sri Maha Bodhi',
        destination: 'Anuradhapura',
        description: 'Sacred Fig Tree',
        location: 'Anuradhapura',
        image: 'assets/images/Auradapura 2.png',
      );

      expect(sriMahaBodhi.lat, closeTo(8.3448, 0.01));
      expect(sriMahaBodhi.lng, closeTo(80.3963, 0.01));
    });

    test('WalkingRouteService correctly parses real GeoJSON walking route geometry from OpenRouteService', () async {
      final mockGeoJson = {
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'geometry': {
              'type': 'LineString',
              'coordinates': [
                [80.396236, 8.350044],
                [80.396250, 8.348000],
                [80.396378, 8.344837],
              ],
            },
            'properties': {
              'summary': {
                'distance': 850.0,
                'duration': 680.0,
              },
            },
          }
        ],
      };

      final mockClient = MockClient((request) async {
        expect(request.url.toString(), contains('foot-walking'));
        expect(request.headers['Authorization'], isNotEmpty);
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['coordinates'], isA<List>());
        return http.Response(jsonEncode(mockGeoJson), 200, headers: {
          'content-type': 'application/json',
        });
      });

      final service = WalkingRouteService(client: mockClient);
      final waypoints = [
        const LatLng(8.350044, 80.396236), // Ruwanwelisaya
        const LatLng(8.344837, 80.396378), // Sri Maha Bodhi
      ];

      final result = await service.getWalkingRoute(waypoints);

      expect(result.isSuccessful, isTrue);
      expect(result.points.length, 3);
      expect(result.points.first.latitude, closeTo(8.350044, 0.0001));
      expect(result.points.first.longitude, closeTo(80.396236, 0.0001));
      expect(result.points.last.latitude, closeTo(8.344837, 0.0001));
      expect(result.points.last.longitude, closeTo(80.396378, 0.0001));
      expect(result.totalDistanceMeters, 850.0);
    });

    test('WalkingRouteService caches routes to prevent repeated API calls on map rebuild', () async {
      int requestCount = 0;
      final mockGeoJson = {
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'geometry': {
              'type': 'LineString',
              'coordinates': [
                [80.396236, 8.350044],
                [80.396378, 8.344837],
              ],
            },
            'properties': {'summary': {'distance': 850.0, 'duration': 680.0}},
          }
        ],
      };

      final mockClient = MockClient((request) async {
        requestCount++;
        return http.Response(jsonEncode(mockGeoJson), 200);
      });

      final service = WalkingRouteService(client: mockClient);
      final waypoints = [
        const LatLng(8.350044, 80.396236),
        const LatLng(8.344837, 80.396378),
      ];

      // Call 1: makes network request
      await service.getWalkingRoute(waypoints);
      expect(requestCount, 1);

      // Call 2: hits in-memory cache, no extra network request
      final cachedResult = await service.getWalkingRoute(waypoints);
      expect(requestCount, 1);
      expect(cachedResult.isSuccessful, isTrue);
      expect(cachedResult.points.length, 2);
    });

    test('WalkingRouteService handles API failure gracefully without crashing', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Rate limit exceeded', 429);
      });

      final service = WalkingRouteService(client: mockClient);
      final waypoints = [
        const LatLng(8.350044, 80.396236),
        const LatLng(8.344837, 80.396378),
      ];

      final result = await service.getWalkingRoute(waypoints);

      // Graceful error handling
      expect(result.isSuccessful, isFalse);
      expect(result.points.isEmpty, isTrue);
      expect(result.errorMessage, contains('Rate limit'));
    });

    test('WalkingRouteService handles single location gracefully', () async {
      final service = WalkingRouteService();
      final waypoints = [const LatLng(8.350044, 80.396236)];

      final result = await service.getWalkingRoute(waypoints);

      expect(result.isSuccessful, isTrue);
      expect(result.points.length, 1);
      expect(result.points.first, waypoints.first);
    });
  });
}
