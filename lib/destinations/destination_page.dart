import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../models/destination.dart';

import '../data/place_information_data.dart';

import '../screens/profile_screen.dart';
import '../screens/saved_places_screen.dart';
import '../screens/plan/walking_plan_page.dart';
import '../widgets/app_navigation_bar.dart';
import 'ruwanwelisaya_detail_page.dart';
import 'sri_maha_bodhi_detail_page.dart';
import 'thuparamaya_detail_page.dart';
import 'abhayagiriya_detail_page.dart';
import 'jetavanaramaya_detail_page.dart';
import 'gadaladeniya_detail_page.dart';
import 'lankathilaka_detail_page.dart';
import 'dambulla_detail_page.dart';
import 'sigiriya_detail_page.dart';
import 'ibbankatuwa_detail_page.dart';

class DestinationPage extends StatefulWidget {
  final Destination destination;

  const DestinationPage({super.key, required this.destination});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  int _currentImage = 0;

  late final PageController _pageController;

  Timer? _autoSlideTimer;

  // =========================================================

  // CEYLON HERITAGE DESIGN COLORS

  // =========================================================

  static const Color backgroundColor = Color(0xFFF6EADA);

  static const Color darkGreen = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color accentColor = Color(0xFF9F5625);

  static const Color greyText = Color(0xFF5F625D);

  static const Color borderColor = Color(0xFFE1D2BD);

  // =========================================================

  // DESTINATION CAROUSEL IMAGES

  // =========================================================

  List<String> get _destinationImages {
    switch (widget.destination.name) {
      case 'Anuradhapura':
        return [
          'assets/images/anuradhapura.png',
          'assets/images/Auradapura 2.png',
          'assets/images/anuradapuraya 3.png',
          'assets/images/anuradapuraya 4.png',
          'assets/images/anurapura 5.png',
          'assets/images/anuradapuraya 6.png',
        ];

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

      case 'Kandy':
        return [
          'assets/images/kandy_main.jpg',
          'assets/images/kandy.png',
          'assets/images/bahirawakanda_buddha.jpg',
          'assets/images/ehalepola_wax_museum.jpg',
          'assets/images/gadaladeniya_vihara.jpg',
          'assets/images/lankathilaka_vihara.jpg',
        ];

      // =====================================================
      // DAMBULLA — 6 slider images
      // =====================================================
      case 'Dambulla':
        return [
          'assets/images/dambulla_cave_temple.jpg',
          'assets/images/sigiriya_rock_fortress.jpg',
          'assets/images/ibbankatuwa_megalithic_tombs.jpg',
          'assets/images/dambulla_cave_temple_exterior.jpg',
          'assets/images/sigiriya_frescoes.jpg',
          'assets/images/sigiriya_lion_paw.jpg',
        ];

      default:
        return [widget.destination.image];
    }
  }

  // =========================================================

  // AUTO IMAGE SLIDER

  // =========================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!_pageController.hasClients) {
        return;
      }

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

  // MAIN PAGE

  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // =====================================================

      // APP BAR

      // =====================================================
      appBar: AppBar(
        backgroundColor: backgroundColor,

        elevation: 0,

        toolbarHeight: 64,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGreen, size: 30),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          widget.destination.name,

          style: GoogleFonts.playfairDisplay(
            color: darkGreen,

            fontSize: 26,

            fontWeight: FontWeight.w700,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: darkGreen, size: 27),

            onPressed: () {},
          ),

          const SizedBox(width: 5),
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

              // HERO IMAGE SLIDER

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

                          height: 230,

                          fit: BoxFit.cover,

                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: cardColor,

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
                          : const Color(0xFFC8B9A5),

                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),

              // =================================================

              // ABOUT

              // =================================================
              const SizedBox(height: 22),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Text(
                  'About',

                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,

                    fontWeight: FontWeight.w700,

                    color: darkGreen,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  width: 55,

                  height: 3,

                  decoration: BoxDecoration(
                    color: accentColor,

                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // =================================================

              // DESCRIPTION

              // =================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Text(
                  widget.destination.description,

                  style: GoogleFonts.inter(
                    fontSize: 14,

                    height: 1.5,

                    color: const Color(0xFF40433F),
                  ),
                ),
              ),

              // =================================================

              // PROVINCE

              // =================================================
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,

                      size: 20,

                      color: accentColor,
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        _getProvince(),

                        style: GoogleFonts.inter(
                          fontSize: 14,

                          fontWeight: FontWeight.w500,

                          color: darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =================================================

              // AUDIO GUIDE

              // =================================================
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: cardColor,

                    borderRadius: BorderRadius.circular(18),

                    border: Border.all(color: borderColor),
                  ),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 46,

                            height: 46,

                            decoration: const BoxDecoration(
                              color: backgroundColor,

                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.headphones_outlined,

                              color: darkGreen,

                              size: 25,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'Audio Guide',

                                  style: GoogleFonts.inter(
                                    fontSize: 15,

                                    fontWeight: FontWeight.w700,

                                    color: darkGreen,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  (widget.destination.name == 'Anuradhapura' ||
                                          widget.destination.name ==
                                              'Dambulla')
                                      ? 'Narrated by Dr. Sensaka Bandara'
                                      : 'Narrated by Heritage Walks',

                                  style: GoogleFonts.inter(
                                    fontSize: 11,

                                    color: greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),

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
                                Icons.play_arrow_rounded,

                                color: backgroundColor,

                                size: 28,
                              ),

                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            '0:00',

                            style: GoogleFonts.inter(
                              fontSize: 9,

                              color: greyText,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerLeft,

                              children: [
                                Container(
                                  height: 3,

                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4C5B0),

                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),

                                Container(
                                  width: 35,

                                  height: 3,

                                  decoration: BoxDecoration(
                                    color: accentColor,

                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            '45:20',

                            style: GoogleFonts.inter(
                              fontSize: 9,

                              color: greyText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // =================================================

              // START WALKING TOUR

              // =================================================
              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: SizedBox(
                  width: double.infinity,

                  height: 58,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WalkingPlanPage(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.directions_walk_rounded, size: 27),

                    label: Text(
                      'START WALKING TOUR',

                      style: GoogleFonts.inter(
                        fontSize: 15,

                        fontWeight: FontWeight.w700,

                        letterSpacing: 0.3,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,

                      foregroundColor: backgroundColor,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),

              // =================================================

              // POPULAR ATTRACTIONS

              // =================================================
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Text(
                  'Popular Attractions',

                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,

                    fontWeight: FontWeight.w700,

                    color: darkGreen,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(
                  width: 85,

                  height: 3,

                  decoration: BoxDecoration(
                    color: accentColor,

                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

              const SizedBox(height: 10),

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
                      borderRadius: BorderRadius.circular(14),

                      onTap: () {
                        _openAttraction(attraction);
                      },

                      child: Container(
                        constraints: const BoxConstraints(minHeight: 76),

                        padding: const EdgeInsets.symmetric(vertical: 8),

                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: borderColor, width: 1),
                          ),
                        ),

                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),

                              child: Image.asset(
                                imagePath,

                                width: 120,

                                height: 58,

                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120,

                                    height: 58,

                                    decoration: BoxDecoration(
                                      color: cardColor,

                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    child: const Icon(
                                      Icons.image_outlined,

                                      color: darkGreen,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Text(
                                attraction,

                                style: GoogleFonts.inter(
                                  fontSize: 15,

                                  color: const Color(0xFF303530),

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const Icon(
                              Icons.chevron_right_rounded,

                              size: 26,

                              color: accentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // =================================================

              // MORE PLACES (hidden for Dambulla)

              // =================================================
              if (widget.destination.name != 'Dambulla') ...[
                const SizedBox(height: 10),

                Center(
                  child: TextButton.icon(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,

                      color: darkGreen,

                      size: 22,
                    ),

                    label: Text(
                      'More places',

                      style: GoogleFonts.inter(
                        fontSize: 14,

                        fontWeight: FontWeight.w600,

                        color: darkGreen,
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // =====================================================

      // BOTTOM NAVIGATION

      // Home | Services | Saved | Profile

      // =====================================================
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pop(context);
            return;
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SavedPlacesScreen(),
              ),
            );
            return;
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Services will be connected next.',
                style: GoogleFonts.inter(),
              ),
              backgroundColor: darkGreen,
              duration: const Duration(seconds: 1),
            ),
          );
        },

      ),
    );
  }



  // =========================================================

  // OPEN HISTORICAL PLACE

  // =========================================================

  void _openAttraction(String attraction) {
    Widget? page;

    switch (attraction) {
      // =====================================================
      // ANURADHAPURA
      // =====================================================

      case 'Ruwanwelisaya':
        page = const RuwanwelisayaDetailPage();
        break;

      case 'Sri Maha Bodhi':
        page = const SriMahaBodhiDetailPage();
        break;

      case 'Thuparamaya':
        page = const ThuparamayaDetailPage();
        break;

      case 'Abhayagiri':
      case 'Abhayagiriya':
        page = const AbhayagiriyaDetailPage();
        break;

      case 'Jetavanaramaya':
        page = const JetavanaramayaDetailPage();
        break;

      // =====================================================

      // POLONNARUWA

      // =====================================================

      case 'Gal Viharaya':
        page = galViharayaInformation;

        break;

      case 'Royal Palace':
        page = royalPalaceInformation;

        break;

      case 'Rankoth Vehera':
        page = rankothVeheraInformation;

        break;

      case 'Lankathilaka Image House':
        page = lankathilakaInformation;

        break;

      case 'Parakrama Samudraya':
        page = parakramaSamudrayaInformation;

        break;

      // =====================================================

      // JAFFNA

      // =====================================================

      case 'Nallur Kandaswamy Kovil':
        page = nallurKandaswamyInformation;

        break;

      case 'Jaffna Fort':
        page = jaffnaFortInformation;

        break;

      case 'Jaffna Public Library':
        page = jaffnaLibraryInformation;

        break;

      case 'Casuarina Beach':
        page = casuarinaBeachInformation;

        break;

      case 'Delft Island':
        page = delftIslandInformation;

        break;

      // =====================================================

      // DOWN SOUTH

      // =====================================================

      case 'Galle Dutch Fort & Lighthouse':
        page = galleFortInformation;

        break;

      case 'Mulgirigala Rock Temple':
        page = mulgirigalaInformation;

        break;

      case 'Kushta Raja Gala':
        page = kushtaRajaGalaInformation;

        break;

      case 'Star Fort (Matara)':
        page = starFortInformation;

        break;

      case 'Ariyapala Masks Museum':
        page = ariyapalaMasksInformation;

        break;

      // =====================================================

      // KANDY

      // =====================================================

      case 'Sri Dalada Maligawa':
        page = sriDaladaMaligawaInformation;
        break;

      case 'Bahirawakanda Buddha Statue':
        page = bahirawakandaBuddhaInformation;
        break;

      case 'Ehalepola Wax Museum':
        page = ahalepolaWalawwaInformation;
        break;

      case 'Gadaladeniya Vihara':
      case 'Gadaladeniya Viharaya':
        page = const GadaladeniyaDetailPage();
        break;

      case 'Lankathilaka Vihara':
      case 'Lankathilaka Viharaya':
        page = const LankathilakaDetailPage();
        break;

      // =====================================================

      // DAMBULLA

      // =====================================================

      case 'Dambulla Cave Temple':
        page = const DambullaDetailPage();
        break;

      case 'Sigiriya Rock Fortress':
        page = const SigiriyaDetailPage();
        break;

      case 'Ibbankatuwa Megalithic Tombs':
        page = const IbbankatuwaDetailPage();
        break;
    }

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
    }
  }

  // =========================================================

  // GET PROVINCE

  // =========================================================

  String _getProvince() {
    switch (widget.destination.name) {
      case 'Anuradhapura':
        return 'North Central Province';

      case 'Polonnaruwa':
        return 'North Central Province';

      case 'Jaffna':
        return 'Northern Province';

      case 'Down South':
        return 'Southern Province';

      case 'Kandy':
        return 'Central Province';

      case 'Dambulla':
        return 'Central Province';

      default:
        return widget.destination.location;
    }
  }

  // =========================================================

  // GET ATTRACTION IMAGE

  // =========================================================

  String _getAttractionImage(String attraction) {
    switch (attraction) {
      // =====================================================

      // ANURADHAPURA

      // =====================================================

      case 'Ruwanwelisaya':
        return 'assets/images/anuradhapura.png';

      case 'Sri Maha Bodhi':
        return 'assets/images/Auradapura 2.png';

      case 'Thuparamaya':
        return 'assets/images/thuparamaya.png';

      case 'Abhayagiri':
        return 'assets/images/anurapura 5.png';

      case 'Jetavanaramaya':
        return 'assets/images/jetavanaramaya.png';

      // =====================================================

      // POLONNARUWA

      // =====================================================

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

      // =====================================================

      // JAFFNA

      // =====================================================

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

      // =====================================================

      // DOWN SOUTH

      // =====================================================

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

      // =====================================================

      // KANDY

      // =====================================================

      case 'Sri Dalada Maligawa':
        return 'assets/images/kandy.png';

      case 'Bahirawakanda Buddha Statue':
        return 'assets/images/bahirawakanda_buddha.jpg';

      case 'Ehalepola Wax Museum':
        return 'assets/images/ehalepola_wax_museum.jpg';

      case 'Gadaladeniya Vihara':
        return 'assets/images/gadaladeniya_vihara.jpg';

      case 'Lankathilaka Vihara':
        return 'assets/images/lankathilaka_vihara.jpg';

      // =====================================================

      // DAMBULLA

      // =====================================================

      case 'Dambulla Cave Temple':
        return 'assets/images/dambulla_cave_temple.jpg';

      case 'Sigiriya Rock Fortress':
        return 'assets/images/sigiriya_rock_fortress.jpg';

      case 'Ibbankatuwa Megalithic Tombs':
        return 'assets/images/ibbankatuwa_megalithic_tombs.jpg';

      // =====================================================

      // DEFAULT

      // =====================================================

      default:
        return 'assets/images/heritage_sketch_bg.jpg';
    }
  }
}
