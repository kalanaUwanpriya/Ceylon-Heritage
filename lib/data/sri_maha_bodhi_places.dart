class SriMahaBodhiNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const SriMahaBodhiNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class SriMahaBodhiData {
  static const String placeName = 'Sri Maha Bodhi';
  static const String destinationName = 'Anuradhapura';
  static const String heroTitle = 'Sri Maha Bodhiya';
  static const String subtitle = 'The Sacred Tree of Enlightenment';
  static const String location = 'Anuradhapura, North Central Province';
  static const String aboutDescription =
      'Sri Maha Bodhi is one of the most sacred and venerated sites in Sri Lanka. It is a sapling of the original Bodhi tree under which Lord Buddha attained enlightenment. Planted in 288 BC during the reign of King Devanampiya Tissa, it is one of the oldest historically documented trees in the world and a profound symbol of peace, spirituality and Sri Lanka’s Buddhist heritage.';
  static const String visitorRating = '4.4 out of 5';
  static const double ratingScore = 4.4;
  static const String reviewCount = '3,120 reviews';
  static const String openingHours = '6:15 AM – 9:00 PM';
  static const String bestTime = 'Early morning or evening';
  static const String entranceFee =
      'Local: Free\nForeign Tourists: LKR 500';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // 4 hero images: slide 1 (original), slide 2 (uploaded), slide 3 (newly uploaded), slide 4 (sri_maha_bodhi_5.jpg)
  static const List<String> heroImages = [
    'assets/images/Auradapura 2.png',
    'assets/images/sri_maha_bodhi_2.jpg',
    'assets/images/sri_maha_bodhi_3.jpg',
    'assets/images/sri_maha_bodhi_5.jpg',
  ];

  static const List<SriMahaBodhiNearbyAttraction> nearbyAttractions = [
    SriMahaBodhiNearbyAttraction(
      name: 'Ruwanwelisaya',
      distance: '~1.0 km',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    SriMahaBodhiNearbyAttraction(
      name: 'Thuparamaya',
      distance: '~0.8 km',
      imagePath: 'assets/images/thuparamaya.png',
    ),
    SriMahaBodhiNearbyAttraction(
      name: 'Jetavanaramaya',
      distance: '~1.0 km',
      imagePath: 'assets/images/jetavanaramaya.png',
    ),
    SriMahaBodhiNearbyAttraction(
      name: 'Abhayagiri Stupa',
      distance: '~3.2 km',
      imagePath: 'assets/images/anurapura 5.png',
    ),
  ];
}
