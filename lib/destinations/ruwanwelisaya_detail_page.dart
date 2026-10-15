import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/ruwanwelisaya_places.dart';
import '../widgets/app_navigation_bar.dart';
import 'sri_maha_bodhi_detail_page.dart';
import 'thuparamaya_detail_page.dart';
import 'abhayagiriya_detail_page.dart';
import 'jetavanaramaya_detail_page.dart';
import '../Reviews/widgets/visitor_rating_card.dart';
import '../widgets/save_place_button.dart';

class RuwanwelisayaDetailPage extends StatefulWidget {
  const RuwanwelisayaDetailPage({super.key});

  @override
  State<RuwanwelisayaDetailPage> createState() => _RuwanwelisayaDetailPageState();
}

class _RuwanwelisayaDetailPageState extends State<RuwanwelisayaDetailPage> {
  late final PageController _pageController;
  Timer? _autoSlideTimer;
  int _currentImage = 0;

  // Ceylon Heritage design system colors
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color darkGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color borderColor = Color(0xFFE1D2BD);
  static const Color textColor = Color(0xFF303530);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      if (RuwanwelisayaData.heroImages.length <= 1) {
        return;
      }
      int nextPage = _currentImage + 1;
      if (nextPage >= RuwanwelisayaData.heroImages.length) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSlider(),
              const SizedBox(height: 10),
              _buildImageDots(),
              const SizedBox(height: 22),
              _buildAboutSection(),
              const SizedBox(height: 20),
              _buildVisitorRating(),
              const SizedBox(height: 22),
              _buildVisitorInformation(),
              const SizedBox(height: 24),
              _buildNearbyAttractions(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          AppNavigationBar.handleNavigation(context, index);
        },
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: darkGreen, size: 29),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        RuwanwelisayaData.destinationName,
        style: GoogleFonts.playfairDisplay(
          color: darkGreen,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        SavePlaceButton(placeId: RuwanwelisayaData.placeName),
        const SizedBox(width: 5),
      ],
    );
  }

  // Hero Slider
  Widget _buildHeroSlider() {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: PageView.builder(
          controller: _pageController,
          itemCount: RuwanwelisayaData.heroImages.length,
          onPageChanged: (index) {
            if (mounted) {
              setState(() {
                _currentImage = index;
              });
            }
          },
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                _buildCandidateImage(_getCandidateImages(index)),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.82),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        RuwanwelisayaData.heroName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        RuwanwelisayaData.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<String> _getCandidateImages(int index) {
    if (index >= RuwanwelisayaData.heroImages.length) {
      return [];
    }
    final primary = RuwanwelisayaData.heroImages[index];
    switch (index) {
      case 0:
        return [primary, 'assets/images/anuradhapura.png'];
      case 1:
        return [
          primary,
          'assets/images/anuradapuraya 3.png',
          'assets/images/anuradapuraya 4.png',
        ];
      case 2:
        return [
          primary,
          'assets/images/ruwanwelisaya_3.jpg',
          'assets/images/anuradapuraya 4.png',
          'assets/images/Auradapura 2.png',
        ];
      case 3:
        return [
          primary,
          'assets/images/ruwanwelisaya.png',
          'assets/images/anuradapuraya 7.png',
        ];
      default:
        return [primary];
    }
  }

  Widget _buildCandidateImage(List<String> candidates) {
    if (candidates.isEmpty) {
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
    }
    return Image.asset(
      candidates.first,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildCandidateImage(candidates.sublist(1));
      },
    );
  }

  // Dots
  Widget _buildImageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(RuwanwelisayaData.heroImages.length, (index) {
        final selected = index == _currentImage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: selected ? 15 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: selected ? darkGreen : const Color(0xFFC8B9A5),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }

  // About Section
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('About'),
        const SizedBox(height: 10),
        Text(
          RuwanwelisayaData.aboutDescription,
          style: GoogleFonts.inter(
            fontSize: 14,
            height: 1.5,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
              color: accentColor,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                RuwanwelisayaData.location,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkGreen,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Visitor Rating
  Widget _buildVisitorRating() {
    return const VisitorRatingCard(
      placeId: 'ruwanwelisaya',
      placeName: RuwanwelisayaData.placeName,
      placeImage: 'assets/images/anuradhapura.png',
      location: RuwanwelisayaData.location,
    );
  }

  // Visitor Information
  Widget _buildVisitorInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Visitor Information'),
        const SizedBox(height: 11),
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              _infoRow(
                Icons.access_time_rounded,
                'Opening Hours',
                RuwanwelisayaData.openingHours,
              ),
              const Divider(height: 1, thickness: 1, color: borderColor),
              _infoRow(
                Icons.calendar_month_outlined,
                'Best Time to Visit',
                RuwanwelisayaData.bestTime,
              ),
              const Divider(height: 1, thickness: 1, color: borderColor),
              _infoRow(
                Icons.local_offer_outlined,
                'Entrance Fee',
                RuwanwelisayaData.entranceFee,
              ),
              const Divider(height: 1, thickness: 1, color: borderColor),
              _infoRow(
                Icons.person_outline_rounded,
                'Dress Code',
                RuwanwelisayaData.dressCode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 30, child: Icon(icon, color: darkGreen, size: 23)),
          const SizedBox(width: 8),
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Nearby Attractions
  Widget _buildNearbyAttractions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Nearby Attractions'),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            RuwanwelisayaData.nearbyAttractions.length,
            (index) {
              final item = RuwanwelisayaData.nearbyAttractions[index];
              final isLast = index == RuwanwelisayaData.nearbyAttractions.length - 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      _openNearbyAttraction(item.name);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 1.25,
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: cardColor,
                                  child: const Icon(
                                    Icons.image_outlined,
                                    color: darkGreen,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: accentColor,
                              size: 13,
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                item.distance,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: 9.5,
                                  color: secondaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openNearbyAttraction(String name) {
    Widget? page;
    switch (name) {
      case 'Sri Maha Bodhiya':
      case 'Sri Maha Bodhi':
        page = const SriMahaBodhiDetailPage();
        break;
      case 'Thuparamaya':
        page = const ThuparamayaDetailPage();
        break;
      case 'Abhayagiri Stupa':
      case 'Abhayagiri':
      case 'Abhayagiriya':
        page = const AbhayagiriyaDetailPage();
        break;
      case 'Jetavanaramaya':
        page = const JetavanaramayaDetailPage();
        break;
    }
    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page!),
      );
    }
  }

  // Section Title
  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 55,
          height: 3,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
