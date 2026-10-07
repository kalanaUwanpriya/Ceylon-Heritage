class ThuparamayaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const ThuparamayaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class ThuparamayaData {
  static const String placeName = 'Thuparamaya';
  static const String destinationName = 'Anuradhapura';
  static const String heroTitle = 'Thuparamaya';
  static const String subtitle = 'The First Buddhist Temple in Sri Lanka';
  static const String location = 'Anuradhapura, North Central Province';
  static const String aboutDescription =
      'Thuparamaya is the first Buddhist temple in Sri Lanka, built during the reign of King Devanampiya Tissa in the 3rd century BCE. It enshrines the right collarbone relic of Lord Buddha, making it one of the most sacred and historically significant sites in the country. The temple represents the beginning of Buddhism in Sri Lanka and continues to be a place of deep spiritual reverence for Buddhists around the world.';
  static const String visitorRating = '4.6 out of 5';
  static const double ratingScore = 4.6;
  static const String reviewCount = '1.2K reviews';
  static const String openingHours = '5:30 AM – 9:45 PM daily';
  static const String ticketCounter = '7:30 AM – 5:30 PM daily';
  static const String bestTime = 'Early morning or evening';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 unique hero images:
  // 1. Current existing first image (thuparamaya.png)
  // 2. Uploaded Image: Vibrant White Stupa Amid Ancient Ruins(1).png (Courtyard with 2 flags)
  // 3. Uploaded Image: Buddhist Stupa Beneath a Vivid Sky(1).png (Stupa with tree on left)
  // 4. Generated Image: thuparamaya_4.jpg (High resolution Thuparamaya stupa with vatadage pillars)
  static const List<String> heroImages = [
    'assets/images/thuparamaya.png',
    'assets/images/Vibrant White Stupa Amid Ancient Ruins(1).png',
    'assets/images/Buddhist Stupa Beneath a Vivid Sky(1).png',
    'assets/images/thuparamaya_4.jpg',
  ];

  static const List<ThuparamayaNearbyAttraction> nearbyAttractions = [
    ThuparamayaNearbyAttraction(
      name: 'Sri Maha Bodhiya',
      distance: '~1.0 km',
      imagePath: 'assets/images/Auradapura 2.png',
    ),
    ThuparamayaNearbyAttraction(
      name: 'Ruwanwelisaya',
      distance: '~1.2 km',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    ThuparamayaNearbyAttraction(
      name: 'Abhayagiri Stupa',
      distance: '~4.0 km',
      imagePath: 'assets/images/anurapura 5.png',
    ),
    ThuparamayaNearbyAttraction(
      name: 'Jetavanaramaya',
      distance: '~1.8 km',
      imagePath: 'assets/images/jetavanaramaya.png',
    ),
  ];
}
