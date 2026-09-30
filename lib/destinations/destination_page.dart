import 'dart:async';

import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../data/place_information_data.dart';

class DestinationPage extends StatefulWidget {
  final Destination destination;

  const DestinationPage({super.key, required this.destination});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  int _currentImage = 0;

  late PageController _pageController;
  Timer? _autoSlideTimer;

  // =========================================================
  // UI COLORS - MATCH REFERENCE
  // =========================================================

  static const Color backgroundColor = Color(0xFFF6ECE2);
  static const Color darkGreen = Color(0xFF183B2B);
  static const Color mediumGreen = Color(0xFF2F6B4F);
  static const Color greyText = Color(0xFF777777);
  static const Color borderColor = Color(0xFFE1D7C8);
  static const Color yellowLine = Color(0xFFD1A84A);

  // =========================================================
  // DESTINATION CAROUSEL IMAGES
  // =========================================================

  List<String> get _destinationImages {
    switch (widget.destination.name) {
      case 'Polonnaruwa':
        return [
          'assets/images/polonnaruwa.png',
          'assets/images/gal_viharaya.png',
          'assets/images/royal_palace.png',
          'assets/images/rankoth_vehera.png',
          'assets/images/lankathilaka.png',
          'assets/images/parakrama_samudraya.png',
        ];

      case 'Jaffna':
        return [
          'assets/images/jaffna.png',
          'assets/images/nallur_kandaswamy.png',
          'assets/images/jaffna_fort.png',
          'assets/images/jaffna_library.png',
          'assets/images/casuarina_beach.png',
          'assets/images/delft_island.png',
        ];

      case 'Down South':
        return [
          'assets/images/down_south.png',
          'assets/images/galle_fort.png',
          'assets/images/mulgirigala.png',
          'assets/images/kushta_raja_gala.png',
          'assets/images/star_fort.png',
          'assets/images/ariyapala_masks.png',
        ];

      default:
        return [widget.destination.image];
    }
  }

  // =========================================================
  // AUTO SLIDE
  // SLOWER THAN BEFORE
  // =========================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!_pageController.hasClients) return;

      int nextPage = _currentImage + 1;

      if (nextPage >= _destinationImages.length) {
        nextPage = 0;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // =====================================================
      // TOP APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        toolbarHeight: 64,

        // BACK ARROW
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGreen, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // DESTINATION NAME
        title: Text(
          widget.destination.name,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          // HEART
          IconButton(
            icon: const Icon(Icons.favorite_border, color: darkGreen, size: 31),
            onPressed: () {},
          ),

          // SHARE / OPEN STYLE ICON
          IconButton(
            icon: const Icon(Icons.open_in_new, color: darkGreen, size: 30),
            onPressed: () {},
          ),

          const SizedBox(width: 8),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // HERO IMAGE
              // =================================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: SizedBox(
                    width: double.infinity,
                    height: 230,

                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _destinationImages.length,

                      onPageChanged: (index) {
                        setState(() {
                          _currentImage = index;
                        });
                      },

                      itemBuilder: (context, index) {
                        return Image.asset(
                          _destinationImages[index],
                          width: double.infinity,
                          fit: BoxFit.cover,

                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFD9D0BD),
                              child: const Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                  color: darkGreen,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              // =================================================
              // IMAGE DOTS
              // =================================================
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_destinationImages.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),

                    margin: const EdgeInsets.symmetric(horizontal: 4),

                    width: _currentImage == index ? 15 : 7,
                    height: 7,

                    decoration: BoxDecoration(
                      color: _currentImage == index
                          ? darkGreen
                          : const Color(0xFFC8C1B7),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              // =================================================
              // ABOUT
              // =================================================
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    // SMALL YELLOW UNDERLINE
                    const SizedBox(height: 5),

                    Container(
                      width: 55,
                      height: 3,
                      decoration: BoxDecoration(
                        color: yellowLine,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 9),

              // DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.destination.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF444444),
                  ),
                ),
              ),

              // =================================================
              // PROVINCE
              // =================================================
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 20, color: darkGreen),

                    const SizedBox(width: 7),

                    Text(
                      _getProvince(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF444444),
                      ),
                    ),
                  ],
                ),
              ),

              // =================================================
              // INFORMATION / SHARE / SERVICES
              // COMPACT LIKE REFERENCE
              // =================================================
              const SizedBox(height: 17),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 62,

                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),

                  child: Row(
                    children: [
                      // INFORMATION
                      Expanded(
                        child: _mainAction(
                          icon: Icons.info,
                          label: 'Information',
                          onTap: () {},
                        ),
                      ),

                      Container(width: 1, height: 34, color: borderColor),

                      // SHARE
                      Expanded(
                        child: _mainAction(
                          icon: Icons.share,
                          label: 'Share',
                          onTap: () {},
                        ),
                      ),

                      Container(width: 1, height: 34, color: borderColor),

                      // SERVICES
                      Expanded(
                        child: _mainAction(
                          icon: Icons.room_service,
                          label: 'Services',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =================================================
              // AUDIO GUIDE
              // COMPACT LIKE REFERENCE
              // =================================================
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF5EADF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),

                  child: Column(
                    children: [
                      // AUDIO TOP ROW
                      Row(
                        children: [
                          // HEADPHONES
                          Container(
                            width: 44,
                            height: 44,

                            decoration: const BoxDecoration(
                              color: Color(0xFFE8E0CB),
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.headphones,
                              color: darkGreen,
                              size: 25,
                            ),
                          ),

                          const SizedBox(width: 12),

                          // TEXT
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Audio Guide',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: darkGreen,
                                  ),
                                ),

                                SizedBox(height: 2),

                                Text(
                                  'Narrated by Heritage Walks',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // PLAY
                          Container(
                            width: 42,
                            height: 42,

                            decoration: const BoxDecoration(
                              color: darkGreen,
                              shape: BoxShape.circle,
                            ),

                            child: IconButton(
                              padding: EdgeInsets.zero,

                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 25,
                              ),

                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // PROGRESS BAR
                      Row(
                        children: [
                          const Text(
                            '0:00',
                            style: TextStyle(fontSize: 9, color: greyText),
                          ),

                          const SizedBox(width: 7),

                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD8D0BE),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                FractionallySizedBox(
                                  widthFactor: 0.35,
                                  child: Container(
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: mediumGreen,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  left: 0,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: mediumGreen,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 7),

                          const Text(
                            '45:20',
                            style: TextStyle(fontSize: 9, color: greyText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // =================================================
              // POPULAR ATTRACTIONS
              // =================================================
              const SizedBox(height: 21),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular Attractions',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    // YELLOW UNDERLINE
                    const SizedBox(height: 5),

                    Container(
                      width: 55,
                      height: 3,
                      decoration: BoxDecoration(
                        color: yellowLine,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // =================================================
              // ATTRACTION LIST
              // =================================================
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: widget.destination.popularAttractions.length,

                itemBuilder: (context, index) {
                  final attraction =
                      widget.destination.popularAttractions[index];

                  final imagePath = _getAttractionImage(attraction);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: InkWell(
                      onTap: () {
                        if (attraction == 'Gal Viharaya') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => galViharayaInformation,
                            ),
                          );
                        }

                        if (attraction == 'Royal Palace') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => royalPalaceInformation,
                            ),
                          );
                        }

                        if (attraction == 'Rankoth Vehera') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => rankothVeheraInformation,
                            ),
                          );
                        }
                        if (attraction == 'Lankathilaka Image House') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => lankathilakaInformation,
                            ),
                          );
                        }
                        if (attraction == 'Parakrama Samudraya') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  parakramaSamudrayaInformation,
                            ),
                          );
                        }
                        if (attraction == 'Nallur Kandaswamy Kovil') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => nallurKandaswamyInformation,
                            ),
                          );
                        }

                        if (attraction == 'Jaffna Fort') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => jaffnaFortInformation,
                            ),
                          );
                        }

                        if (attraction == 'Jaffna Public Library') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => jaffnaLibraryInformation,
                            ),
                          );
                        }

                        if (attraction == 'Casuarina Beach') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => casuarinaBeachInformation,
                            ),
                          );
                        }

                        if (attraction == 'Delft Island') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => delftIslandInformation,
                            ),
                          );
                        }
                        if (attraction == 'Galle Dutch Fort & Lighthouse') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => galleFortInformation,
                            ),
                          );
                        }

                        if (attraction == 'Mulgirigala Rock Temple') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => mulgirigalaInformation,
                            ),
                          );
                        }

                        if (attraction == 'Kushta Raja Gala') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => kushtaRajaGalaInformation,
                            ),
                          );
                        }

                        if (attraction == 'Star Fort (Matara)') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => starFortInformation,
                            ),
                          );
                        }

                        if (attraction == 'Ariyapala Masks Museum') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ariyapalaMasksInformation,
                            ),
                          );
                        }
                      },

                      child: Container(
                        height: 70,

                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: borderColor, width: 1),
                          ),
                        ),

                        child: Row(
                          children: [
                            // RECTANGULAR IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(9),

                              child: Image.asset(
                                imagePath,

                                width: 125,
                                height: 54,

                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 125,
                                    height: 54,

                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5E0D2),
                                      borderRadius: BorderRadius.circular(9),
                                    ),

                                    child: const Icon(
                                      Icons.image_outlined,
                                      color: mediumGreen,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 16),

                            // PLACE NAME ONLY
                            Expanded(
                              child: Text(
                                attraction,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // RIGHT ARROW
                            const Icon(
                              Icons.chevron_right,
                              size: 26,
                              color: Color(0xFF555555),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // =================================================
              // MORE PLACES
              // =================================================
              const SizedBox(height: 10),

              Center(
                child: TextButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: darkGreen,
                    size: 22,
                  ),

                  label: const Text(
                    'More places',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: darkGreen,
                    ),
                  ),

                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),

              // =================================================
              // START WALKING TOUR
              // =================================================
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 62,

                  child: ElevatedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.directions_walk, size: 29),

                    label: const Text(
                      'START WALKING TOUR',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      elevation: 0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // KEEP IMAGE 3 STYLE
      // =====================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        type: BottomNavigationBarType.fixed,

        backgroundColor: backgroundColor,

        selectedItemColor: darkGreen,

        unselectedItemColor: const Color(0xFF555555),

        selectedFontSize: 12,
        unselectedFontSize: 12,

        elevation: 0,

        items: const [
          // HOME
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'HOME',
          ),

          // MAP
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined, size: 28),
            label: 'MAP',
          ),

          // SAVED
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 30),
            label: 'SAVED',
          ),

          // SERVICES
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined, size: 29),
            label: 'SERVICES',
          ),

          // PROFILE
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 30),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // INFORMATION / SHARE / SERVICES ACTION
  // =========================================================

  Widget _mainAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, size: 24, color: darkGreen),

          const SizedBox(height: 3),

          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PROVINCE
  // =========================================================

  String _getProvince() {
    switch (widget.destination.name) {
      case 'Polonnaruwa':
        return 'North Central Province';

      case 'Jaffna':
        return 'Northern Province';

      case 'Down South':
        return 'Southern Province';

      default:
        return widget.destination.location;
    }
  }

  // =========================================================
  // ATTRACTION IMAGE PATH
  // =========================================================

  String _getAttractionImage(String attraction) {
    switch (attraction) {
      // -------------------------------------------------------
      // POLONNARUWA
      // -------------------------------------------------------

      case 'Gal Viharaya':
        return 'assets/images/gal_viharaya.png';

      case 'Royal Palace':
        return 'assets/images/royal_palace.png';

      case 'Rankoth Vehera':
        return 'assets/images/rankoth_vehera.png';

      case 'Lankathilaka Image House':
        return 'assets/images/lankathilaka.png';

      case 'Parakrama Samudraya':
        return 'assets/images/parakrama_samudraya.png';

      // -------------------------------------------------------
      // JAFFNA
      // -------------------------------------------------------

      case 'Nallur Kandaswamy Kovil':
        return 'assets/images/nallur_kandaswamy.png';

      case 'Jaffna Fort':
        return 'assets/images/jaffna_fort.png';

      case 'Jaffna Public Library':
        return 'assets/images/jaffna_library.png';

      case 'Casuarina Beach':
        return 'assets/images/casuarina_beach.png';

      case 'Delft Island':
        return 'assets/images/delft_island.png';

      // -------------------------------------------------------
      // DOWN SOUTH
      // -------------------------------------------------------

      case 'Galle Dutch Fort & Lighthouse':
        return 'assets/images/galle_fort.png';

      case 'Mulgirigala Rock Temple':
        return 'assets/images/mulgirigala.png';

      case 'Kushta Raja Gala':
        return 'assets/images/kushta_raja_gala.png';

      case 'Star Fort (Matara)':
        return 'assets/images/star_fort.png';

      case 'Ariyapala Masks Museum':
        return 'assets/images/ariyapala_masks.png';

      // -------------------------------------------------------
      // DEFAULT
      // -------------------------------------------------------

      default:
        return 'assets/images/heritage_sketch_bg.jpg';
    }
  }
}
