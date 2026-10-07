class RuwanwelisayaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const RuwanwelisayaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class RuwanwelisayaData {
  static const String placeName = 'Ruwanwelisaya';
  static const String destinationName = 'Anuradhapura';
  static const String heroName = 'Ruwanwelisaya';
  static const String subtitle = 'A Timeless Symbol of Faith';
  static const String location = 'Anuradhapura, North Central Province';
  static const String aboutDescription =
      'Ruwanwelisaya is one of the most sacred and historically significant stupas in Sri Lanka. Located in Anuradhapura, it was built by King Dutugemunu and is considered one of the most important Buddhist monuments in the country.';
  static const String visitorRating = '4.3 out of 5';
  static const double ratingScore = 4.3;
  static const String reviewCount = '2,340 reviews';
  static const String openingHours = '5:00 AM – 10:00 PM';
  static const String bestTime = 'Early morning or evening';
  static const String entranceFee = 'Local: Free\nForeigner: Rs. 9,000';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // 4 Ruwanwelisaya-specific hero images
  static const List<String> heroImages = [
    'assets/images/anuradhapura.png',
    'assets/images/anuradhapura 3.png',
    'assets/images/ruwanwalisaya 3.png',
    'assets/images/ruwanwalisaya.png',
  ];

  static const List<RuwanwelisayaNearbyAttraction> nearbyAttractions = [
    RuwanwelisayaNearbyAttraction(
      name: 'Sri Maha Bodhi',
      distance: '~1.0 km',
      imagePath: 'assets/images/Auradapura 2.png',
    ),
    RuwanwelisayaNearbyAttraction(
      name: 'Thuparamaya',
      distance: '~1.2 km',
      imagePath: 'assets/images/thuparamaya.png',
    ),
    RuwanwelisayaNearbyAttraction(
      name: 'Abhayagiri Stupa',
      distance: '~4.0 km',
      imagePath: 'assets/images/anurapura 5.png',
    ),
    RuwanwelisayaNearbyAttraction(
      name: 'Jetavanaramaya',
      distance: '~1.8 km',
      imagePath: 'assets/images/jetavanaramaya.png',
    ),
  ];
}
