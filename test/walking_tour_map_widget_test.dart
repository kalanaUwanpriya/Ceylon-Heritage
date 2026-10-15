import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:ceylon_heritage/models/historical_place.dart';
import 'package:ceylon_heritage/services/route_generation_service.dart';
import 'package:ceylon_heritage/services/walking_route_service.dart';
import 'package:ceylon_heritage/screens/plan/walking_tour_map_screen.dart';
import 'package:latlong2/latlong.dart' hide Path;

// 1x1 transparent PNG bytes for mock HTTP client
final List<int> _transparentPngBytes = [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient extends Fake implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async => _MockHttpClientRequest();

  @override
  void close({bool force = false}) {}
}

class _MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  final HttpHeaders headers = _MockHttpHeaders();

  @override
  bool followRedirects = true;

  @override
  int maxRedirects = 5;

  @override
  int contentLength = 0;

  @override
  bool bufferOutput = true;

  @override
  bool persistentConnection = true;

  @override
  void add(List<int> data) {}

  @override
  Future addStream(Stream<List<int>> stream) async {}

  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();
}

class _MockHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  @override
  final HttpHeaders headers = _MockHttpHeaders();
  @override
  final int statusCode = 200;
  @override
  final String reasonPhrase = 'OK';
  @override
  final int contentLength = _transparentPngBytes.length;
  @override
  final HttpClientResponseCompressionState compressionState =
      HttpClientResponseCompressionState.notCompressed;
  @override
  final bool isRedirect = false;
  @override
  final List<RedirectInfo> redirects = const [];
  @override
  final bool persistentConnection = true;
  @override
  final X509Certificate? certificate = null;
  @override
  final HttpConnectionInfo? connectionInfo = null;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.value(_transparentPngBytes).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<HttpClientResponse> redirect([String? method, Uri? url, bool? followLoops]) async => this;
  @override
  Future<Socket> detachSocket() async => throw UnimplementedError();

  @override
  List<Cookie> get cookies => const [];
}

class _MockHttpHeaders extends Fake implements HttpHeaders {
  @override
  int contentLength = _transparentPngBytes.length;
  @override
  ContentType? contentType = ContentType('image', 'png');

  @override
  List<String>? operator [](String name) => null;
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  String? value(String name) => null;
  @override
  void forEach(void Function(String name, List<String> values) action) {
    action('content-type', ['image/png']);
  }
}

class _MockWalkingRouteService extends Fake implements WalkingRouteService {
  @override
  Future<WalkingRouteResult> getWalkingRoute(
    List<LatLng> waypoints, {
    bool forceRefresh = false,
  }) async {
    return WalkingRouteResult(points: waypoints, isSuccessful: true);
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  group('WalkingTourMapScreen Widget Tests', () {
    final testPlaces = [
      HistoricalPlace(
        id: 'sri_maha_bodhi',
        name: 'Sri Maha Bodhi',
        destination: 'Anuradhapura',
        category: 'Sacred Garden',
        description: 'The sacred fig tree in the Mahamewna Gardens.',
        location: 'Anuradhapura Sacred City',
        image: 'assets/images/sri_maha_bodhi.jpg',
        latitude: 8.3448,
        longitude: 80.3965,
        rating: 3.0,
      ),
      HistoricalPlace(
        id: 'ruwanwelisaya',
        name: 'Ruwanwelisaya',
        destination: 'Anuradhapura',
        category: 'Ancient Stupa',
        description: 'A magnificent stupa and one of the ancient wonders.',
        location: 'Anuradhapura Sacred City',
        image: 'assets/images/ruwanwelisaya.jpg',
        latitude: 8.3500,
        longitude: 80.3962,
        rating: 3.0,
      ),
      HistoricalPlace(
        id: 'thuparamaya',
        name: 'Thuparamaya',
        destination: 'Anuradhapura',
        category: 'Buddhist Temple',
        description: 'The first Buddhist temple in Sri Lanka.',
        location: 'Anuradhapura Sacred City',
        image: 'assets/images/thuparamaya.jpg',
        latitude: 8.3547,
        longitude: 80.3967,
        rating: 2.5,
      ),
    ];

    final stops = [
      WalkingRouteStop(
        stepNumber: 1,
        place: testPlaces[0],
        realAverageRating: 3.0,
        reviewCount: 15,
        arrivalTime: '08:00 AM',
        departureTime: '08:20 AM',
        stayDurationMinutes: 20,
        stayDurationLabel: '20m',
        distanceToNextKm: 0.85,
        distanceToNextLabel: '850 m',
        walkMinutesToNext: 12,
        walkTimeToNextLabel: '12 min walk',
      ),
      WalkingRouteStop(
        stepNumber: 2,
        place: testPlaces[1],
        realAverageRating: 3.0,
        reviewCount: 22,
        arrivalTime: '08:32 AM',
        departureTime: '08:57 AM',
        stayDurationMinutes: 25,
        stayDurationLabel: '25m',
        distanceToNextKm: 0.60,
        distanceToNextLabel: '600 m',
        walkMinutesToNext: 10,
        walkTimeToNextLabel: '10 min walk',
      ),
      WalkingRouteStop(
        stepNumber: 3,
        place: testPlaces[2],
        realAverageRating: 2.5,
        reviewCount: 8,
        arrivalTime: '09:07 AM',
        departureTime: '09:27 AM',
        stayDurationMinutes: 20,
        stayDurationLabel: '20m',
      ),
    ];

    final tour = GeneratedWalkingTour(
      destinationName: 'Anuradhapura',
      circuitTitle: 'Anuradhapura Sacred Heritage Walk',
      headline: 'A journey through sacred shrines',
      description: 'Explore the ancient heart of Buddhist heritage.',
      totalDurationLabel: '1h 27m',
      totalDistanceLabel: '1.45 km',
      tempo: 'Quick',
      ratingFilter: 'Any',
      stops: stops,
    );

    testWidgets('Renders FlutterMap with custom numbered markers', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WalkingTourMapScreen(
            tour: tour,
            routeService: _MockWalkingRouteService(),
          ),
        ),
      );
      await tester.pump();

      // Verify header title
      expect(find.text('Ceylon Heritage'), findsOneWidget);
      expect(find.text('3 Historical Stops · Walking Circuit'), findsOneWidget);

      // Verify FlutterMap is embedded
      expect(find.byType(FlutterMap), findsOneWidget);

      // Verify custom numbered markers ①, ②, ③
      expect(find.text('①'), findsOneWidget);
      expect(find.text('②'), findsOneWidget);
      expect(find.text('③'), findsOneWidget);
    });

    testWidgets('Tapping a numbered marker opens place card with Navigate with Maps button',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: WalkingTourMapScreen(
            tour: tour,
            routeService: _MockWalkingRouteService(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap on marker 1 ('Sri Maha Bodhi')
      await tester.tap(find.text('①'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Place card should appear with details
      expect(find.text('Sri Maha Bodhi'), findsWidgets);
      expect(find.text('Sacred Garden'), findsOneWidget);
      expect(find.text('Navigate with Maps'), findsOneWidget);

      // Tap on marker 2 ('Ruwanwelisaya')
      await tester.tap(find.text('②'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Ruwanwelisaya'), findsWidgets);
      expect(find.text('Ancient Stupa'), findsOneWidget);
      expect(find.text('Navigate with Maps'), findsOneWidget);
    });

    testWidgets('Single place tour handles bounds and centers without crash',
        (WidgetTester tester) async {
      final singleTour = GeneratedWalkingTour(
        destinationName: 'Anuradhapura',
        circuitTitle: 'Single Stop Walk',
        headline: 'Single site visit',
        description: 'Single destination.',
        totalDurationLabel: '20m',
        totalDistanceLabel: '0 km',
        tempo: 'Quick',
        ratingFilter: 'Any',
        stops: [
          WalkingRouteStop(
            stepNumber: 1,
            place: testPlaces[0],
            realAverageRating: 3.0,
            reviewCount: 5,
            arrivalTime: '08:00 AM',
            departureTime: '08:20 AM',
            stayDurationMinutes: 20,
            stayDurationLabel: '20m',
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: WalkingTourMapScreen(
            tour: singleTour,
            routeService: _MockWalkingRouteService(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(FlutterMap), findsOneWidget);
      expect(find.text('①'), findsOneWidget);
      expect(find.text('1 Historical Stops · Walking Circuit'), findsOneWidget);
    });
  });
}
