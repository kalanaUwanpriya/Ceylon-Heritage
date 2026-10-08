class GadaladeniyaNearbyAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const GadaladeniyaNearbyAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class GadaladeniyaData {
  static const String placeName = 'Gadaladeniya Vihara';
  static const String destinationName = 'Gadaladeniya Vihara';
  static const String heroTitle = 'Gadaladeniya Vihara';
  static const String subtitle = 'Ancient Buddhist Temple with South Indian Architecture';
  static const String location = 'Gadaladeniya, Kandy, Sri Lanka';
  static const String aboutDescription =
      'Gadaladeniya Vihara is an ancient Buddhist temple built in the 14th century. It features a unique blend of South Indian and Sri Lankan architectural styles and is one of the remarkable medieval temples near Kandy.';
  static const String visitorRating = '4.5 out of 5';
  static const double ratingScore = 4.5;
  static const String reviewCount = '1,842 reviews';
  static const String openingHours = 'Daily from 7:00 AM to 7:00 PM';
  static const String bestTime = 'Early morning or afternoon';
  static const String entranceFee = 'Local: Free\nForeign Tourists: Rs. 500';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  // Exactly 4 slider images:
  // 1. Existing Gadaladeniya Vihara asset
  // 2. Uploaded image 1
  // 3. Uploaded image 2
  // 4. Uploaded image 3
  static const List<String> heroImages = [
    'assets/images/gadaladeniya_vihara.jpg',
    'assets/images/gadaladeniya_2.png',
    'assets/images/gadaladeniya_3.png',
    'assets/images/gadaladeniya_4.png',
  ];

  static const List<GadaladeniyaNearbyAttraction> nearbyAttractions = [
    GadaladeniyaNearbyAttraction(
      name: 'Sri Dalada Maligawa',
      distance: '~11 km',
      imagePath: 'assets/images/kandy.png',
    ),
    GadaladeniyaNearbyAttraction(
      name: 'Bahirawakanda Buddha Statue',
      distance: '~12 km',
      imagePath: 'assets/images/bahirawakanda_buddha.jpg',
    ),
    GadaladeniyaNearbyAttraction(
      name: 'Ehalepola Wax Museum',
      distance: '~11 km',
      imagePath: 'assets/images/ehalepola_wax_museum.jpg',
    ),
    GadaladeniyaNearbyAttraction(
      name: 'Lankathilaka Vihara',
      distance: '~3 km',
      imagePath: 'assets/images/lankathilaka_vihara.jpg',
    ),
  ];
}
