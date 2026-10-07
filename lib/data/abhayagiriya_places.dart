class AbhayagiriyaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const AbhayagiriyaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class AbhayagiriyaData {
  static const String placeName = 'Abhayagiriya';
  static const String destinationName = 'Anuradhapura';
  static const String heroTitle = 'Abhayagiriya';
  static const String subtitle = 'A Great Monastic Legacy';
  static const String location = 'Anuradhapura, North Central Province';
  static const String aboutDescription =
      'Abhayagiriya is one of the most significant ancient monasteries in Sri Lanka and was a major centre of Buddhist learning. It was established in the 1st century BCE and developed into a vast monastic complex with impressive stupas, monasteries, and ancient structures. Abhayagiriya reflects the rich cultural, religious and educational heritage of the Anuradhapura era.';
  static const String visitorRating = '4.5 out of 5';
  static const double ratingScore = 4.5;
  static const String reviewCount = '980 reviews';
  static const String openingHours = '6:00 AM – 8:00 PM daily';
  static const String ticketCounter = '6:00 AM – 8:00 PM daily';
  static const String bestTime = 'Early morning or evening';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 unique hero images:
  // 1. Current existing first image (anurapura 5.png)
  // 2. Uploaded Image 1: Ancient Stupa Among Weathered Pillars.png
  // 3. Uploaded Image 2: Ancient Stupa Courtyard Under Blue Skies.png
  // 4. Uploaded Image 3: Grand Brick Stupa Under Blue Skies.png
  static const List<String> heroImages = [
    'assets/images/anurapura 5.png',
    'assets/images/Ancient Stupa Among Weathered Pillars.png',
    'assets/images/Ancient Stupa Courtyard Under Blue Skies.png',
    'assets/images/Grand Brick Stupa Under Blue Skies.png',
  ];

  static const List<AbhayagiriyaNearbyAttraction> nearbyAttractions = [
    AbhayagiriyaNearbyAttraction(
      name: 'Sri Maha Bodhiya',
      distance: '~4.0 km',
      imagePath: 'assets/images/Auradapura 2.png',
    ),
    AbhayagiriyaNearbyAttraction(
      name: 'Ruwanwelisaya',
      distance: '~1.5 km',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    AbhayagiriyaNearbyAttraction(
      name: 'Thuparamaya',
      distance: '~2.0 km',
      imagePath: 'assets/images/thuparamaya.png',
    ),
    AbhayagiriyaNearbyAttraction(
      name: 'Jetavanaramaya',
      distance: '~1.8 km',
      imagePath: 'assets/images/jetavanaramaya.png',
    ),
  ];
}
