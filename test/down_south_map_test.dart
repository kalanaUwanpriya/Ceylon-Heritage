import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:ceylon_heritage/data/historical_places_data.dart';
import 'package:ceylon_heritage/models/historical_place.dart';
import 'package:ceylon_heritage/services/historical_places_api.dart';
import 'package:ceylon_heritage/services/route_generation_service.dart';
import 'package:ceylon_heritage/services/walking_route_service.dart';
import 'package:ceylon_heritage/screens/plan/walking_tour_map_screen.dart';

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
  final bool shouldFail;
  _MockWalkingRouteService({this.shouldFail = false});

  @override
  Future<WalkingRouteResult> getWalkingRoute(
    List<LatLng> waypoints, {
    bool forceRefresh = false,
  }) async {
    if (shouldFail) {
      return const WalkingRouteResult(
        points: [],
        isSuccessful: false,
        errorMessage: 'Authentication failed with OpenRouteService. Check API key.',
      );
    }
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

  group('Down South Historical Places & Verified Coordinates Tests', () {
    test('downSouthPlaces contains all 4 required historical attractions', () {
      expect(downSouthPlaces.length, 4);

      final names = downSouthPlaces.map((p) => p.name).toList();
      expect(names[0], contains('Galle Dutch Fort'));
      expect(names[1], contains('Kushta Raja Gala'));
      expect(names[2], contains('Star Fort'));
      expect(names[3].toLowerCase(), contains('mulgirigala'));
    });

    test('All 4 Down South attractions have verified, distinct geographic coordinates', () {
      for (final place in downSouthPlaces) {
        expect(place.lat, isNotNull);
        expect(place.lng, isNotNull);
        expect(place.lat, inInclusiveRange(5.9, 6.2),
            reason: '${place.name} latitude should be in Southern Province range (5.9..6.2), got ${place.lat}');
        expect(place.lng, inInclusiveRange(80.1, 80.8),
            reason: '${place.name} longitude should be in Southern Province range (80.1..80.8), got ${place.lng}');
      }

      // Verify each coordinate is distinct
      final uniqueCoords = downSouthPlaces.map((p) => '${p.lat},${p.lng}').toSet();
      expect(uniqueCoords.length, 4, reason: 'All 4 locations must have distinct coordinates');
    });

    test('HistoricalPlacesApi retrieves the 4 Down South places for destination "Down South"', () async {
      final places = await const HistoricalPlacesApi().getHistoricalPlaces(destination: 'Down South');
      expect(places.length, 4);
      for (final p in places) {
        expect(p.destination, 'Down South');
      }
    });

    test('Destination fallback coordinates for Down South resolve to Galle', () {
      final unmappedPlace = HistoricalPlace(
        name: 'Southern Site',
        destination: 'Down South',
        description: 'Test',
        location: 'Southern Province',
        image: 'assets/images/down_south.png',
      );
      expect(unmappedPlace.lat, closeTo(6.0269, 0.01));
      expect(unmappedPlace.lng, closeTo(80.2170, 0.01));
    });
  });

  group('Down South Tour Route Generation Tests', () {
    test('Generates Down South circuit title and tour headline', () {
      final filteredDownSouth = downSouthPlaces
          .map((p) => FilteredPlace(place: p, realAverageRating: 3.0, reviewCount: 5))
          .toList();

      final route = RouteGenerationService.buildTourRoute(
        eligiblePlaces: filteredDownSouth,
        tempo: 'Moderate',
        timeAvailable: '1 Day',
        ratingFilter: 'Any',
        destinationName: 'Down South',
      );

      expect(route.circuitTitle, 'DOWN SOUTH · HISTORICAL CIRCUIT');
      expect(route.headline, contains('Down South'));
      expect(route.stops.length, 4);
    });
  });

  group('Down South Map Rendering & NaN Crash Prevention Widget Tests', () {
    late GeneratedWalkingTour downSouthTour;

    setUp(() {
      final filteredDownSouth = downSouthPlaces
          .map((p) => FilteredPlace(place: p, realAverageRating: 3.0, reviewCount: 5))
          .toList();

      downSouthTour = RouteGenerationService.buildTourRoute(
        eligiblePlaces: filteredDownSouth,
        tempo: 'Moderate',
        timeAvailable: '1 Day',
        ratingFilter: 'Any',
        destinationName: 'Down South',
      );
    });

    testWidgets('Down South map renders without NaN crash and displays all 4 markers', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: WalkingTourMapScreen(
            tour: downSouthTour,
            routeService: _MockWalkingRouteService(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify FlutterMap renders
      expect(find.byType(FlutterMap), findsOneWidget);

      // Verify all 4 custom numbered markers are rendered ①, ②, ③, ④
      expect(find.text('①'), findsOneWidget);
      expect(find.text('②'), findsOneWidget);
      expect(find.text('③'), findsOneWidget);
      expect(find.text('④'), findsOneWidget);

      // Verify Header says 4 Historical Stops
      expect(find.text('4 Historical Stops · Walking Circuit'), findsOneWidget);

      // Verify First place card is selected (Galle Dutch Fort & Lighthouse)
      expect(find.text('Galle Dutch Fort & Lighthouse'), findsOneWidget);
      expect(find.text('Navigate with Maps'), findsOneWidget);
    });

    testWidgets('Tapping marker 2 switches card to Star Fort, Matara', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: WalkingTourMapScreen(
            tour: downSouthTour,
            routeService: _MockWalkingRouteService(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap marker ③
      await tester.tap(find.text('③'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Card should now display Star Fort, Matara
      expect(find.text('Star Fort, Matara'), findsOneWidget);
    });

    testWidgets('Handles route calculation failure safely without NaN crash or red screen', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: WalkingTourMapScreen(
            tour: downSouthTour,
            routeService: _MockWalkingRouteService(shouldFail: true),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Map remains visible
      expect(find.byType(FlutterMap), findsOneWidget);

      // Error banner with Retry is visible
      expect(find.text('Retry'), findsOneWidget);
    });
  });
}
