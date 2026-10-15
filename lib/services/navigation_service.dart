import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service responsible for launching external navigation applications (Google Maps)
/// in WALKING mode to a selected historical destination.
class NavigationService {
  /// Opens Google Maps (or the user's preferred installed maps app) with the given
  /// destination in WALKING mode.
  static Future<bool> navigateWithMaps({
    required double latitude,
    required double longitude,
    required String title,
    String? description,
  }) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (availableMaps.isNotEmpty) {
        // Find Google Maps if installed, otherwise pick the first installed maps app
        final targetMap = availableMaps.firstWhere(
          (m) =>
              m.mapType == MapType.google ||
              m.mapType == MapType.googleGo,
          orElse: () => availableMaps.first,
        );

        await targetMap.showDirections(
          destination: Coords(latitude, longitude),
          destinationTitle: title,
          directionsMode: DirectionsMode.walking,
        );
        return true;
      } else {
        // Fallback: Launch Google Maps walking navigation via browser / intent URL
        return await _launchGoogleMapsWebUrl(latitude, longitude, title);
      }
    } catch (_) {
      // Fallback in case of platform or plugin exceptions
      return await _launchGoogleMapsWebUrl(latitude, longitude, title);
    }
  }

  static Future<bool> _launchGoogleMapsWebUrl(
    double lat,
    double lng,
    String title,
  ) async {
    final encodedTitle = Uri.encodeComponent(title);
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=&travelmode=walking',
    );

    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final fallbackUri = Uri.parse(
        'https://maps.google.com/?q=$lat,$lng($encodedTitle)&mode=w',
      );
      if (await canLaunchUrl(fallbackUri)) {
        return await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
    }
    return false;
  }
}
