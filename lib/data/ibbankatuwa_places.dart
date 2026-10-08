class IbbankatuwaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const IbbankatuwaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class IbbankatuwaData {
  static const String placeName = 'Ibbankatuwa Megalithic Tombs';
  static const String destinationName = 'Dambulla';
  static const String heroTitle = 'Ibbankatuwa Megalithic Tombs';
  static const String subtitle =
      'Prehistoric Iron Age Burial Site & Ancient Cemetery';
  static const String location = 'Dambulla, Sri Lanka';
  static const String aboutDescription =
      'Ibbankatuwa Megalithic Tombs is a prehistoric burial site near Dambulla, containing ancient megalithic tombs dating back to the Iron Age. It is an important archaeological site that reveals early human settlements in Sri Lanka.';
  static const String visitorRating = '4.5 out of 5';
  static const double ratingScore = 4.5;
  static const String reviewCount = '1,240 reviews';
  static const String openingHours = 'Open daily from 7:00 AM to 5:00 PM';
  static const String bestTime = 'Morning or late afternoon';
  static const String entranceFee =
      'Local: Rs. 20 to Rs. 120\nForeign Tourists: Rs. 1,400–1,500';
  static const String dressCode =
      'Comfortable walking attire and sun protection';

  // Exactly 4 slider images:
  // 1. Existing Ibbankatuwa Megalithic Tombs image from assets
  // 2. Uploaded Ibbankatuwa Megalithic Tombs image 1
  // 3. Uploaded Ibbankatuwa Megalithic Tombs image 2
  // 4. Uploaded Ibbankatuwa Megalithic Tombs image 3
  static const List<String> heroImages = [
    'assets/images/ibbankatuwa_megalithic_tombs.jpg',
    'assets/images/ibbankatuwa_2.jpg',
    'assets/images/ibbankatuwa_3.jpg',
    'assets/images/ibbankatuwa_4.jpg',
  ];

  static const List<IbbankatuwaNearbyAttraction> nearbyAttractions = [
    IbbankatuwaNearbyAttraction(
      name: 'Dambulla Cave Temple',
      distance: '3 km',
      imagePath: 'assets/images/dambulla_cave_temple.jpg',
    ),
    IbbankatuwaNearbyAttraction(
      name: 'Sigiriya Rock Fortress',
      distance: '20 km',
      imagePath: 'assets/images/sigiriya_rock_fortress.jpg',
    ),
  ];
}
