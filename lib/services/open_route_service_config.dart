/// Configuration for the OpenRouteService API.
///
/// Can be configured via compile-time environment variable:
/// `--dart-define=OPEN_ROUTE_SERVICE_API_KEY=your_key_here`
/// or by calling [OpenRouteServiceConfig.setApiKey].
class OpenRouteServiceConfig {
  static String _apiKey = const String.fromEnvironment(
    'OPEN_ROUTE_SERVICE_API_KEY',
    defaultValue: '5b3ce3597851110001cf6248a39a2f7c006540b68ceb264eece92b21',
  );

  /// Current active OpenRouteService API key
  static String get apiKey => _apiKey;

  /// Sets the API key dynamically at runtime
  static void setApiKey(String key) {
    _apiKey = key;
  }

  /// Base URL for walking directions API (foot-walking)
  static const String footWalkingUrl =
      'https://api.openrouteservice.org/v2/directions/foot-walking/geojson';
}
