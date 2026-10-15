import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../screens/profile_screen.dart';
import '../screens/saved_places_screen.dart';
import '../widgets/app_navigation_bar.dart';
import '../widgets/save_place_button.dart';
import '../Reviews/widgets/visitor_rating_card.dart';

class PlaceInformationPage extends StatefulWidget {
  final String? placeId;
  final String placeName;

  final String destinationName;

  final String subtitle;

  final String description;

  final String location;

  final String rating;

  final String reviews;

  final String openingHours;

  final String bestTime;

  final String entranceFee;

  final String dressCode;

  final List<String> heroImages;

  final List<String> nearbyNames;

  final List<String> nearbyImages;

  final List<String> nearbyDistances;

  const PlaceInformationPage({
    super.key,

    this.placeId,
    required this.placeName,

    required this.destinationName,

    required this.subtitle,

    required this.description,

    required this.location,

    required this.rating,

    required this.reviews,

    required this.openingHours,

    required this.bestTime,

    required this.entranceFee,

    required this.dressCode,

    required this.heroImages,

    required this.nearbyNames,

    required this.nearbyImages,

    required this.nearbyDistances,
  });

  String get effectivePlaceId =>
      placeId ??
      placeName
          .toLowerCase()
          .trim()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
          .replaceAll(RegExp(r'^_+|_+$'), '');

  @override
  State<PlaceInformationPage> createState() => _PlaceInformationPageState();
}

class _PlaceInformationPageState extends State<PlaceInformationPage> {
  late final PageController _pageController;

  Timer? _autoSlideTimer;

  int _currentImage = 0;

  // =========================================================

  // CEYLON HERITAGE DESIGN COLORS

  // =========================================================

  static const Color backgroundColor = Color(0xFFF6EADA);

  static const Color darkGreen = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color accentColor = Color(0xFF9F5625);

  static const Color borderColor = Color(0xFFE1D2BD);

  static const Color textColor = Color(0xFF303530);

  static const Color secondaryTextColor = Color(0xFF5F625D);

  // =========================================================

  // INITIAL SETUP

  // =========================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }

      if (widget.heroImages.length <= 1) {
        return;
      }

      int nextPage = _currentImage + 1;

      if (nextPage >= widget.heroImages.length) {
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),

      child: Scaffold(
        backgroundColor: backgroundColor,

        appBar: _buildAppBar(),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _buildHero(),

                const SizedBox(height: 10),

                _buildImageDots(),

                const SizedBox(height: 20),

                _buildAbout(),

                const SizedBox(height: 20),

                _buildVisitorRating(),

                const SizedBox(height: 22),

                _buildVisitorInformation(),

                const SizedBox(height: 24),

                _buildNearbyAttractions(),

                const SizedBox(height: 0.05),
              ],
            ),
          ),
        ),

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

      ),
    );
  }

  // =========================================================

  // APP BAR

  // =========================================================

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
        widget.destinationName,

        maxLines: 1,

        overflow: TextOverflow.ellipsis,

        style: GoogleFonts.playfairDisplay(
          color: darkGreen,

          fontSize: 23,

          fontWeight: FontWeight.w700,
        ),
      ),

      centerTitle: true,

      actions: [
        SavePlaceButton(
          placeId: widget.placeId ?? widget.placeName,
          placeName: widget.placeName,
          destinationName: widget.destinationName,
          location: widget.location,
          description: widget.description,
          image: widget.heroImages.isNotEmpty ? widget.heroImages.first : null,
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  // =========================================================

  // HERO IMAGE

  // =========================================================

  Widget _buildHero() {
    if (widget.heroImages.isEmpty) {
      return _imageErrorBox();
    }

    return SizedBox(
      width: double.infinity,

      height: 220,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),

        child: PageView.builder(
          controller: _pageController,

          itemCount: widget.heroImages.length,

          onPageChanged: (index) {
            if (!mounted) {
              return;
            }

            setState(() {
              _currentImage = index;
            });
          },

          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,

              children: [
                Image.asset(
                  widget.heroImages[index],

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return _imageErrorBox();
                  },
                ),

                // Bottom dark gradient
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

                // Place name and subtitle
                Positioned(
                  left: 18,

                  right: 18,

                  bottom: 16,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        widget.placeName,

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
                        widget.subtitle,

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

  // =========================================================

  // IMAGE ERROR

  // =========================================================

  Widget _imageErrorBox() {
    return Container(
      width: double.infinity,

      height: 220,

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(22),
      ),

      alignment: Alignment.center,

      child: const Icon(
        Icons.image_not_supported_outlined,

        color: darkGreen,

        size: 42,
      ),
    );
  }

  // =========================================================

  // IMAGE DOTS

  // =========================================================

  Widget _buildImageDots() {
    if (widget.heroImages.length <= 1) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 12,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: List.generate(widget.heroImages.length, (index) {
          final bool selected = index == _currentImage;

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
      ),
    );
  }

  // =========================================================

  // ABOUT

  // =========================================================

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        _sectionTitle('About'),

        const SizedBox(height: 10),

        Text(
          widget.description,

          style: GoogleFonts.inter(color: textColor, fontSize: 14, height: 1.5),
        ),

        const SizedBox(height: 12),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const Icon(
              Icons.location_on_outlined,

              color: accentColor,

              size: 21,
            ),

            const SizedBox(width: 6),

            Expanded(
              child: Text(
                widget.location,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: GoogleFonts.inter(
                  fontSize: 13,

                  color: darkGreen,

                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(width: 6),

            Text(
              'More',

              style: GoogleFonts.inter(
                fontSize: 13,

                fontWeight: FontWeight.w600,

                color: darkGreen,
              ),
            ),

            const SizedBox(width: 2),

            const Icon(
              Icons.keyboard_arrow_down_rounded,

              color: darkGreen,

              size: 21,
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================

  // VISITOR RATING

  // =========================================================

  Widget _buildVisitorRating() {
    return VisitorRatingCard(
      placeId: widget.effectivePlaceId,
      placeName: widget.placeName,
      placeImage: widget.heroImages.isNotEmpty
          ? widget.heroImages.first
          : 'assets/images/anuradhapura.png',
      location: widget.location,
    );
  }

  // =========================================================

  // VISITOR INFORMATION

  // =========================================================

  Widget _buildVisitorInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        _sectionTitle('Visitor Information'),

        const SizedBox(height: 11),

        Container(
          decoration: BoxDecoration(
            color: cardColor,

            border: Border.all(color: borderColor),

            borderRadius: BorderRadius.circular(18),
          ),

          child: Column(
            children: [
              _informationRow(
                Icons.access_time_rounded,

                'Opening Hours',

                widget.openingHours,
              ),

              _divider(),

              _informationRow(
                Icons.calendar_month_outlined,

                'Best Time to Visit',

                widget.bestTime,
              ),

              _divider(),

              _informationRow(
                Icons.local_offer_outlined,

                'Entrance Fee',

                widget.entranceFee,
              ),

              _divider(),

              _informationRow(
                Icons.person_outline_rounded,

                'Dress Code',

                widget.dressCode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================

  // INFORMATION ROW

  // =========================================================

  Widget _informationRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(width: 34, child: Icon(icon, color: darkGreen, size: 24)),

          const SizedBox(width: 9),

          SizedBox(
            width: 120,

            child: Text(
              title,

              style: GoogleFonts.inter(
                fontSize: 12,

                color: textColor,

                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              value,

              style: GoogleFonts.inter(fontSize: 12, color: secondaryTextColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 1, color: borderColor);
  }

  // =========================================================

  // NEARBY ATTRACTIONS

  // =========================================================

  Widget _buildNearbyAttractions() {
    final int availableCount = [
      widget.nearbyNames.length,

      widget.nearbyImages.length,

      widget.nearbyDistances.length,
    ].reduce((value, element) => value < element ? value : element);

    final int count = availableCount > 4 ? 4 : availableCount;

    if (count == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Expanded(child: _sectionTitle('Nearby Attractions')),

            Text(
              'See All',

              style: GoogleFonts.inter(
                fontSize: 13,

                color: darkGreen,

                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(width: 2),

            const Icon(
              Icons.chevron_right_rounded,

              color: accentColor,

              size: 22,
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: List.generate(count, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == count - 1 ? 0 : 7),

                child: _nearbyCard(index),
              ),
            );
          }),
        ),
      ],
    );
  }

  // =========================================================

  // SINGLE NEARBY CARD

  // =========================================================

  Widget _nearbyCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),

          child: AspectRatio(
            aspectRatio: 1.25,

            child: Image.asset(
              widget.nearbyImages[index],

              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: cardColor,

                  alignment: Alignment.center,

                  child: const Icon(
                    Icons.image_not_supported_outlined,

                    color: darkGreen,

                    size: 22,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          widget.nearbyNames[index],

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

              size: 14,
            ),

            const SizedBox(width: 2),

            Expanded(
              child: Text(
                widget.nearbyDistances[index],

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
    );
  }

  // =========================================================

  // SECTION TITLE

  // =========================================================

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: GoogleFonts.playfairDisplay(
            color: darkGreen,

            fontSize: 21,

            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 4),

        Container(
          width: 45,

          height: 3,

          decoration: BoxDecoration(
            color: accentColor,

            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  // =========================================================

  // BOTTOM NAVIGATION

  // Home | Services | Saved | Profile

}
