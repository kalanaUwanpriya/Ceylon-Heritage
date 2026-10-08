class LankathilakaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const LankathilakaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class LankathilakaData {
  static const String placeName = 'Lankathilaka Vihara';
  static const String destinationName = 'Lankathilaka Vihara';
  static const String heroTitle = 'Lankathilaka Vihara';
  static const String subtitle = 'The Majestic Medieval Rock Temple of Kandy';
  static const String location = 'Lankathilaka, Kandy, Sri Lanka';
  static const String aboutDescription =
      'Lankathilaka Vihara is a magnificent ancient Buddhist temple built in the 14th century during the reign of King Bhuvanekabahu IV. It stands on a rock and is known for its impressive multi-storey structure and ancient carvings.';
  static const String visitorRating = '4.5 out of 5';
  static const double ratingScore = 4.5;
  static const String reviewCount = '1,620 reviews';
  static const String openingHours = 'Daily from 7:00 AM to 7:00 PM';
  static const String bestTime = 'Early morning or afternoon';
  static const String entranceFee = 'Local: Free\nForeign Tourists: Rs. 500';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 slider images:
  // 1. Existing Lankathilaka Vihara asset
  // 2. Uploaded image 1
  // 3. Uploaded image 2
  // 4. Uploaded image 3
  static const List<String> heroImages = [
    'assets/images/lankathilaka_vihara.jpg',
    'assets/images/lankathilaka_2.png',
    'assets/images/lankathilaka_3.png',
    'assets/images/lankathilaka_4.png',
  ];

  static const List<LankathilakaNearbyAttraction> nearbyAttractions = [
    LankathilakaNearbyAttraction(
      name: 'Gadaladeniya Vihara',
      distance: '3 km',
      imagePath: 'assets/images/gadaladeniya_vihara.jpg',
    ),
    LankathilakaNearbyAttraction(
      name: 'Sri Dalada Maligawa',
      distance: '13 km',
      imagePath: 'assets/images/kandy.png',
    ),
    LankathilakaNearbyAttraction(
      name: 'Ehelepola Wax Museum',
      distance: '13 km',
      imagePath: 'assets/images/ehalepola_wax_museum.jpg',
    ),
    LankathilakaNearbyAttraction(
      name: 'Bahirawakanda Buddha Statue',
      distance: '15 km',
      imagePath: 'assets/images/bahirawakanda_buddha.jpg',
    ),
  ];
}
