class JetavanaramayaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const JetavanaramayaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class JetavanaramayaData {
  static const String placeName = 'Jetavanaramaya';
  static const String destinationName = 'Anuradhapura';
  static const String heroTitle = 'Jetavanaramaya';
  static const String subtitle = 'The Tallest Brick Stupa in the World';
  static const String location = 'Anuradhapura, North Central Province';
  static const String aboutDescription =
      'Jetavanaramaya is one of the largest and tallest ancient stupas in the world, built by King Mahasena in the 4th century CE within the sacred Jetavana Monastery. At its peak, it stood as the third tallest structure in the ancient world, after the Great Pyramids of Giza. It enshrines a part of the sash or belt tied by Lord Buddha and represents a monumental engineering triumph of ancient Sri Lanka.';
  static const String visitorRating = '4.7 out of 5';
  static const double ratingScore = 4.7;
  static const String reviewCount = '1.8K reviews';
  static const String openingHours = '6:00 AM – 8:00 PM daily';
  static const String ticketCounter = '6:00 AM – 8:00 PM daily';
  static const String bestTime = 'Early morning or evening';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 unique hero images:
  // 1. Current existing first image (jetavanaramaya.png)
  // 2. Generated Image 2: jetavanaramaya_2.jpg
  // 3. Generated Image 3: jetavanaramaya_3.jpg
  // 4. Generated Image 4: jetavanaramaya_4.jpg
  static const List<String> heroImages = [
    'assets/images/jetavanaramaya.png',
    'assets/images/jetavanaramaya_2.jpg',
    'assets/images/jetavanaramaya_3.jpg',
    'assets/images/jetavanaramaya_4.jpg',
  ];

  static const List<JetavanaramayaNearbyAttraction> nearbyAttractions = [
    JetavanaramayaNearbyAttraction(
      name: 'Sri Maha Bodhiya',
      distance: '~2.0 km',
      imagePath: 'assets/images/Auradapura 2.png',
    ),
    JetavanaramayaNearbyAttraction(
      name: 'Ruwanwelisaya',
      distance: '~1.8 km',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    JetavanaramayaNearbyAttraction(
      name: 'Thuparamaya',
      distance: '~1.8 km',
      imagePath: 'assets/images/thuparamaya.png',
    ),
    JetavanaramayaNearbyAttraction(
      name: 'Abhayagiri Stupa',
      distance: '~1.8 km',
      imagePath: 'assets/images/anurapura 5.png',
    ),
  ];
}
