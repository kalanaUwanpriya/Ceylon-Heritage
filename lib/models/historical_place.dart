class HistoricalPlace {
  final String? id;
  final String name;
  final String destination;
  final String description;
  final String location;
  final String image;
  final String? category;
  final double? latitude;
  final double? longitude;
  final double? rating;

  HistoricalPlace({
    this.id,
    required this.name,
    required this.destination,
    required this.description,
    required this.location,
    required this.image,
    this.category,
    this.latitude,
    this.longitude,
    this.rating,
  });

  String get placeId =>
      id ??
      name
          .toLowerCase()
          .trim()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
          .replaceAll(RegExp(r'^_+|_+$'), '');

  String get placeCategory => category ?? 'Historical Site';

  double get lat =>
      latitude ??
      _defaultCoordinates[placeId]?.lat ??
      _defaultCoordinates[placeId.replaceAll('_image_house', '')]?.lat ??
      (destination.toLowerCase().contains('polonnaruwa')
          ? 7.9405
          : destination.toLowerCase().contains('dambulla')
              ? 7.8566
              : destination.toLowerCase().contains('south')
                  ? 6.0269
                  : 8.3500);

  double get lng =>
      longitude ??
      _defaultCoordinates[placeId]?.lng ??
      _defaultCoordinates[placeId.replaceAll('_image_house', '')]?.lng ??
      (destination.toLowerCase().contains('polonnaruwa')
          ? 81.0028
          : destination.toLowerCase().contains('dambulla')
              ? 80.6483
              : destination.toLowerCase().contains('south')
                  ? 80.2170
                  : 80.3962);

  static const Map<String, ({double lat, double lng})> _defaultCoordinates = {
    'ruwanwelisaya': (lat: 8.350044, lng: 80.396236),
    'sri_maha_bodhi': (lat: 8.344837, lng: 80.396378),
    'thuparamaya': (lat: 8.354674, lng: 80.396195),
    'jetavanaramaya': (lat: 8.351633, lng: 80.403248),
    'abhayagiri': (lat: 8.371241, lng: 80.395171),
    'abhayagiriya': (lat: 8.371241, lng: 80.395171),
    'gal_viharaya': (lat: 7.9647, lng: 81.0044),
    'royal_palace': (lat: 7.9405, lng: 81.0028),
    'rankoth_vehera': (lat: 7.9547, lng: 81.0028),
    'lankathilaka': (lat: 7.9602, lng: 81.0019),
    'lankathilaka_image_house': (lat: 7.9602, lng: 81.0019),
    'parakrama_samudraya': (lat: 7.9197, lng: 80.9856),
    'dambulla_cave_temple': (lat: 7.8566, lng: 80.6483),
    'dambulla': (lat: 7.8566, lng: 80.6483),
    'sigiriya_rock_fortress': (lat: 7.9570, lng: 80.7603),
    'sigiriya': (lat: 7.9570, lng: 80.7603),
    'ibbankatuwa_megalithic_tombs': (lat: 7.8389, lng: 80.6120),
    'ibbankatuwa': (lat: 7.8389, lng: 80.6120),
    'sri_dalada_maligawa': (lat: 7.2936, lng: 80.6413),
    'nallur_kandaswamy_kovil': (lat: 9.6745, lng: 80.0296),
    'jaffna_fort': (lat: 9.6617, lng: 80.0097),
    // Down South
    'galle_dutch_fort_lighthouse': (lat: 6.0269, lng: 80.2170),
    'galle_dutch_fort': (lat: 6.0269, lng: 80.2170),
    'galle_fort': (lat: 6.0269, lng: 80.2170),
    'galle': (lat: 6.0269, lng: 80.2170),
    'star_fort_matara': (lat: 5.9490, lng: 80.5447),
    'star_fort': (lat: 5.9490, lng: 80.5447),
    'mulgirigala_rock_temple': (lat: 6.0822, lng: 80.7675),
    'mulgirigala': (lat: 6.0822, lng: 80.7675),
    'kushta_raja_gala': (lat: 5.9744, lng: 80.4286),
    'kushta_raja': (lat: 5.9744, lng: 80.4286),
    'ariyapala_masks_museum': (lat: 6.2366, lng: 80.0543),
    'ariyapala_masks': (lat: 6.2366, lng: 80.0543),
  };
}
