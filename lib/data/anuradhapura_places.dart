class HeroSliderItem {
  final String imagePath;
  final String title;
  final String subtitle;

  const HeroSliderItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class AnuradhapuraAttraction {
  final String name;
  final String distance;
  final String imagePath;

  const AnuradhapuraAttraction({
    required this.name,
    required this.distance,
    required this.imagePath,
  });
}

class AnuradhapuraData {
  static const String destinationName = 'Anuradhapura';
  static const String location = 'Anuradhapura, North Central Province';
  static const String aboutDescription =
      'Anuradhapura is one of the most sacred and historically significant ancient cities in Sri Lanka. It was the first capital of the island and a centre of Buddhist civilization. Renowned for its magnificent stupas, ancient monasteries, and well-preserved ruins, Anuradhapura reflects the rich cultural and spiritual heritage of Sri Lanka.';
  static const String visitorRating = '4.3 out of 5';
  static const double ratingScore = 4.3;
  static const String reviewCount = '2,340 reviews';
  static const String openingHours = '5:00 AM – 10:00 PM';
  static const String bestTime = 'Early morning or evening';
  static const String entranceFee = 'Local: Free\nForeigner: Rs. 9,000';
  static const String dressCode =
      'Modest attire (shoulders and knees covered)';

  static const List<HeroSliderItem> heroSliderItems = [
    HeroSliderItem(
      imagePath: 'assets/images/anuradhapura.png',
      title: 'Ruwanwelisaya',
      subtitle: 'A Timeless Symbol of Faith',
    ),
    HeroSliderItem(
      imagePath: 'assets/images/Auradapura 2.png',
      title: 'Sri Maha Bodhi',
      subtitle: 'The Sacred Fig Tree',
    ),
    HeroSliderItem(
      imagePath: 'assets/images/thuparamaya.png',
      title: 'Thuparamaya',
      subtitle: 'The First Buddhist Temple in Sri Lanka',
    ),
    HeroSliderItem(
      imagePath: 'assets/images/anurapura 5.png',
      title: 'Abhayagiri',
      subtitle: 'A Major Monastery Site',
    ),
    HeroSliderItem(
      imagePath: 'assets/images/jetavanaramaya.png',
      title: 'Jetavanaramaya',
      subtitle: 'A Prominent Ancient Stupa',
    ),
  ];

  static const List<AnuradhapuraAttraction> popularAttractions = [
    AnuradhapuraAttraction(
      name: 'Ruwanwelisaya',
      distance: '~0.5 km',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    AnuradhapuraAttraction(
      name: 'Sri Maha Bodhi',
      distance: '~1.0 km',
      imagePath: 'assets/images/Auradapura 2.png',
    ),
    AnuradhapuraAttraction(
      name: 'Thuparamaya',
      distance: '~1.2 km',
      imagePath: 'assets/images/thuparamaya.png',
    ),
    AnuradhapuraAttraction(
      name: 'Abhayagiri Stupa',
      distance: '~4.0 km',
      imagePath: 'assets/images/anurapura 5.png',
    ),
    AnuradhapuraAttraction(
      name: 'Jetavanaramaya',
      distance: '~1.8 km',
      imagePath: 'assets/images/jetavanaramaya.png',
    ),
  ];
}
