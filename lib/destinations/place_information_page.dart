import 'dart:async';

import 'package:flutter/material.dart';

<<<<<<< Updated upstream
=======
import 'package:google_fonts/google_fonts.dart';

import '../screens/profile_screen.dart';
import '../widgets/app_navigation_bar.dart';

>>>>>>> Stashed changes
class PlaceInformationPage extends StatefulWidget {
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

  @override
  State<PlaceInformationPage> createState() => _PlaceInformationPageState();
}

class _PlaceInformationPageState extends State<PlaceInformationPage> {
  late PageController _pageController;
  Timer? _autoSlideTimer;

  int _currentImage = 0;

  static const Color backgroundColor = Color(0xFFF6ECE2);
  static const Color darkGreen = Color(0xFF183B2B);
  static const Color gold = Color(0xFFD1A84A);
  static const Color borderColor = Color(0xFFE1D7C8);
  static const Color textColor = Color(0xFF303030);

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || !_pageController.hasClients) return;

      if (widget.heroImages.length <= 1) return;

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

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),

                const SizedBox(height: 12),

                _buildHero(),

                const SizedBox(height: 8),

                _buildImageDots(),

                const SizedBox(height: 8),

                _buildAbout(),

                const SizedBox(height: 14),

                _buildVisitorRating(),

                const SizedBox(height: 16),

                _buildVisitorInformation(),

                const SizedBox(height: 18),

                _buildNearbyAttractions(),

                const SizedBox(height: 95),
              ],
            ),
          ),
        ),
<<<<<<< Updated upstream
        bottomNavigationBar: _buildBottomNavigation(),
=======

        bottomNavigationBar: AppNavigationBar(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            if (index == 0) {
              Navigator.pop(context);
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
                  index == 1
                      ? 'Services will be connected next.'
                      : 'Saved will be connected next.',
                  style: GoogleFonts.inter(),
                ),
                backgroundColor: darkGreen,
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
>>>>>>> Stashed changes
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
            icon: const Icon(Icons.arrow_back, color: darkGreen, size: 29),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(width: 7),

          Text(
            widget.destinationName,
            style: const TextStyle(
              color: darkGreen,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO IMAGE
  // ============================================================

  Widget _buildHero() {
    if (widget.heroImages.isEmpty) {
      return _imageErrorBox();
    }

    return SizedBox(
      width: double.infinity,
      height: 175,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.heroImages.length,
          onPageChanged: (index) {
            if (!mounted) return;

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

                // Bottom gradient
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 75,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.78),
                        ],
                      ),
                    ),
                  ),
                ),

                // Hero title and subtitle
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.placeName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
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

  // ============================================================
  // IMAGE ERROR
  // ============================================================

  Widget _imageErrorBox() {
    return Container(
      color: const Color(0xFFE6DDCE),
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: darkGreen,
        size: 38,
      ),
    );
  }

  // ============================================================
  // IMAGE DOTS
  // ============================================================

  Widget _buildImageDots() {
    return SizedBox(
      height: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.heroImages.length, (index) {
          final bool selected = index == _currentImage;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? darkGreen : const Color(0xFFC9C9C9),
            ),
          );
        }),
      ),
    );
  }

  // ============================================================
  // ABOUT
  // ============================================================

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('About'),

        const SizedBox(height: 7),

        Text(
          widget.description,
          style: const TextStyle(
            color: textColor,
            fontSize: 13.5,
            height: 1.38,
          ),
        ),

        const SizedBox(height: 9),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: darkGreen, size: 21),

            const SizedBox(width: 6),

            Expanded(
              child: Text(
                widget.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: textColor),
              ),
            ),

            const SizedBox(width: 6),

            const Text(
              'More',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),

            const SizedBox(width: 4),

            const Icon(Icons.keyboard_arrow_down, color: darkGreen, size: 21),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // VISITOR RATING
  // ============================================================

  Widget _buildVisitorRating() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Visitor Rating',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202020),
            ),
          ),

          const SizedBox(height: 5),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: List.generate(3, (_) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.star, color: gold, size: 27),
                  );
                }),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  '${widget.rating} out of 3 (${widget.reviews} reviews)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: textColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VISITOR INFORMATION
  // ============================================================

  Widget _buildVisitorInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Visitor Information'),

        const SizedBox(height: 7),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _informationRow(
                Icons.access_time,
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

              _informationRow(Icons.person, 'Dress Code', widget.dressCode),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INFORMATION ROW
  // ============================================================

  Widget _informationRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 35, child: Icon(icon, color: darkGreen, size: 26)),

          const SizedBox(width: 9),

          SizedBox(
            width: 125,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12.5, color: textColor),
            ),
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12.5, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 1, color: borderColor);
  }

  // ============================================================
  // NEARBY ATTRACTIONS
  // ============================================================

  Widget _buildNearbyAttractions() {
    final int count = widget.nearbyNames.length > 4
        ? 4
        : widget.nearbyNames.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: _sectionTitle('Nearby Attractions')),

            const Text(
              'See All',
              style: TextStyle(fontSize: 13, color: textColor),
            ),

            const SizedBox(width: 2),

            const Icon(Icons.chevron_right, color: darkGreen, size: 21),
          ],
        ),

        const SizedBox(height: 7),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(count, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == count - 1 ? 0 : 6),
                child: _nearbyCard(index),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ============================================================
  // SINGLE NEARBY CARD
  // ============================================================

  Widget _nearbyCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 1.32,
            child: Image.asset(
              widget.nearbyImages[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE6DDCE),
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

        const SizedBox(height: 4),

        Text(
          widget.nearbyNames[index],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),

        const SizedBox(height: 2),

        Row(
          children: [
            const Icon(Icons.location_on, color: darkGreen, size: 15),

            const SizedBox(width: 2),

            Expanded(
              child: Text(
                widget.nearbyDistances[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10.5, color: textColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        Container(
          width: 32,
          height: 3,
          decoration: BoxDecoration(
            color: gold,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

<<<<<<< Updated upstream
  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 10),
        height: 72,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 'HOME', true),
            _navItem(Icons.location_on_outlined, 'MAP', false),
            _navItem(Icons.favorite_border, 'SAVED', false),
            _navItem(Icons.grid_view_outlined, 'SERVICES', false),
            _navItem(Icons.person_outline, 'PROFILE', false),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool selected) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 27,
            color: selected ? darkGreen : const Color(0xFF555555),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              color: selected
                  ? const Color(0xFF202020)
                  : const Color(0xFF555555),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
=======
  // =========================================================

>>>>>>> Stashed changes
}
