class DambullaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const DambullaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class DambullaData {
  static const String placeName = 'Dambulla Cave Temple';
  static const String destinationName = 'Dambulla';
  static const String heroTitle = 'Dambulla Cave Temple';
  static const String subtitle =
      'UNESCO World Heritage Cave Temple Complex';
  static const String location = 'Dambulla, Sri Lanka';
  static const String aboutDescription =
      'Dambulla Cave Temple is a UNESCO World Heritage Site and the largest, best-preserved cave temple complex in Sri Lanka, featuring 153 Buddha statues and ancient murals spanning 2,100 square metres.';
  static const String visitorRating = '4.8 out of 5';
  static const double ratingScore = 4.8;
  static const String reviewCount = '3,420 reviews';
  static const String openingHours = 'Daily from 7:00 AM to 7:00 PM';
  static const String bestTime = 'Early morning or late afternoon';
  static const String entranceFee = 'Local: Free\nForeign Tourists: Rs. 3,000';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 slider images:
  // 1. Existing Dambulla Cave Temple asset 1
  // 2. Existing Dambulla Cave Temple asset 2
  // 3. Existing Dambulla Cave Temple asset 3
  // 4. Uploaded Dambulla Cave Temple image 4
  static const List<String> heroImages = [
    'assets/images/dambulla_cave_temple.jpg',
    'assets/images/dambulla_cave_temple_exterior.jpg',
    'assets/images/dambulla.png',
    'assets/images/dambulla_cave_temple_4.png',
  ];

  static const List<DambullaNearbyAttraction> nearbyAttractions = [
    DambullaNearbyAttraction(
      name: 'Sigiriya Rock Fortress',
      distance: '19 km',
      imagePath: 'assets/images/sigiriya_rock_fortress.jpg',
    ),
    DambullaNearbyAttraction(
      name: 'Ibbankatuwa Megalithic Tombs',
      distance: '5 km',
      imagePath: 'assets/images/ibbankatuwa_megalithic_tombs.jpg',
    ),
  ];
}
