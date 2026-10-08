class SigiriyaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const SigiriyaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class SigiriyaData {
  static const String placeName = 'Sigiriya Rock Fortress';
  static const String destinationName = 'Dambulla';
  static const String heroTitle = 'Sigiriya Rock Fortress';
  static const String subtitle =
      'Ancient Rock Fortress and Palace Ruin';
  static const String location = 'Sigiriya, Sri Lanka';
  static const String aboutDescription =
      'Sigiriya is an ancient rock fortress and palace ruin built by King Kashyapa. Rising 200 metres above the surrounding jungle, it is a UNESCO World Heritage Site and one of the best-preserved examples of ancient urban planning.';
  static const String visitorRating = '4.9 out of 5';
  static const double ratingScore = 4.9;
  static const String reviewCount = '8,950 reviews';
  static const String openingHours = 'Daily from 7:00 AM to 7:00 PM';
  static const String bestTime = 'Early morning or late afternoon';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 slider images:
  // 1. Existing Sigiriya Rock Fortress image 1
  // 2. Existing Sigiriya Lion Paw image 2
  // 3. Existing Sigiriya Frescoes image 3
  // 4. Sigiriya 4th image
  static const List<String> heroImages = [
    'assets/images/sigiriya_rock_fortress.jpg',
    'assets/images/sigiriya_lion_paw.jpg',
    'assets/images/sigiriya_frescoes.jpg',
    'assets/images/sigiriya_4.jpg',
  ];

  static const List<SigiriyaNearbyAttraction> nearbyAttractions = [
    SigiriyaNearbyAttraction(
      name: 'Dambulla Cave Temple',
      distance: '19 km',
      imagePath: 'assets/images/dambulla_cave_temple.jpg',
    ),
    SigiriyaNearbyAttraction(
      name: 'Ibbankatuwa Megalithic Tombs',
      distance: '5 km',
      imagePath: 'assets/images/ibbankatuwa_megalithic_tombs.jpg',
    ),
  ];
}
