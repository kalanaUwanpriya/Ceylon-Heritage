import '../models/historical_place.dart';
import '../data/historical_places_data.dart';

/// Service/API for retrieving historical places.
class HistoricalPlacesApi {
  const HistoricalPlacesApi();

  /// Step 1 of the required process:
  /// Get historical places from the existing places data / API.
  Future<List<HistoricalPlace>> getHistoricalPlaces({String? destination}) async {
    final dest = (destination ?? 'Anuradhapura').trim().toLowerCase();

    if (dest.contains('polonnaruwa')) {
      return List.unmodifiable(polonnaruwaPlaces);
    } else if (dest.contains('jaffna')) {
      return List.unmodifiable(jaffnaPlaces);
    } else if (dest.contains('south')) {
      return List.unmodifiable(downSouthPlaces);
    } else if (dest.contains('kandy')) {
      return List.unmodifiable(kandyPlaces);
    } else if (dest.contains('dambulla')) {
      return List.unmodifiable(dambullaPlaces);
    }

    // Default to Anuradhapura
    return List.unmodifiable(anuradhapuraPlaces);
  }

  /// Finds a historical place by its unique place ID.
  Future<HistoricalPlace?> getPlaceById(String placeId) async {
    final all = [
      ...anuradhapuraPlaces,
      ...polonnaruwaPlaces,
      ...jaffnaPlaces,
      ...downSouthPlaces,
      ...kandyPlaces,
      ...dambullaPlaces,
    ];
    final normalized = placeId.trim().toLowerCase().replaceAll('-', '_');
    for (final p in all) {
      if (p.placeId == normalized || p.placeId == placeId) {
        return p;
      }
    }
    return null;
  }
}
