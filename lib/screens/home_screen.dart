import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/historical_places_data.dart';
import '../destinations/destination_page.dart';
import '../widgets/app_navigation_bar.dart';
import 'profile_screen.dart';

class PlaceItem {
  final String title;
  final String subtitle;
  final String imagePath;

  const PlaceItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ============================================================
  // CEYLON HERITAGE DESIGN SYSTEM
  // ============================================================

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  int _selectedIndex = 0;

  // ============================================================
  // DESTINATIONS
  // ============================================================

  final List<PlaceItem> _places = const [
    PlaceItem(
      title: 'Anuradhapura',
      subtitle: 'Sacred City of Ancient Sri Lanka',
      imagePath: 'assets/images/anuradhapura.png',
    ),
    PlaceItem(
      title: 'Polonnaruwa',
      subtitle: 'Ancient City',
      imagePath: 'assets/images/polonnaruwa.png',
    ),
    PlaceItem(
      title: 'Jaffna',
      subtitle: 'Northern Cultural Heritage',
      imagePath: 'assets/images/jaffna.png',
    ),
    PlaceItem(
      title: 'Down South',
      subtitle: 'Southern Heritage & Coast',
      imagePath: 'assets/images/down_south.png',
    ),
    PlaceItem(
      title: 'Kandy',
      subtitle: 'Temple of the Tooth',
      imagePath: 'assets/images/kandy.png',
    ),
    PlaceItem(
      title: 'Galle',
      subtitle: 'Dutch Heritage',
      imagePath: 'assets/images/galle.png',
    ),
    PlaceItem(
      title: 'Sigiriya',
      subtitle: 'Rock Fortress',
      imagePath: 'assets/images/sigiriya.png',
    ),
    PlaceItem(
      title: 'Yapahuwa',
      subtitle: 'Hill Fortress',
      imagePath: 'assets/images/yapahuwa.png',
    ),
  ];

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // HEADER
              // ==================================================
              _buildHeader(),

              // ==================================================
              // SEARCH
              // ==================================================
              _buildSearchBar(),

              const SizedBox(height: 18),

              // ==================================================
              // DESTINATION CARDS
              // ==================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _places.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final place = _places[index];

                    return _buildPlaceCard(context, place);
                  },
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _handleNavigation,
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          // ------------------------------------------------------------
          // HERITAGE BACKGROUND SKETCH
          // ------------------------------------------------------------
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.30),
                    Colors.black.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.60, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: Image.asset(
                'assets/images/heritage_sketch_bg.jpg',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.42),
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),
          ),

          // ------------------------------------------------------------
          // HEADER CONTENT
          // ------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'Where will you explore today?',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: secondaryTextColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // ------------------------------------------------------
                // NOTIFICATION BUTTON
                // ------------------------------------------------------
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: backgroundColor.withValues(alpha: 0.94),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    tooltip: 'Notifications',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Notifications tapped',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: primaryColor,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accentColor.withValues(alpha: 0.10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          cursorColor: primaryColor,
          style: GoogleFonts.inter(
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: 'Search places, routes...',
            hintStyle: GoogleFonts.inter(
              color: secondaryTextColor.withValues(alpha: 0.75),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 10),
              child: Icon(Icons.search_rounded, color: primaryColor, size: 22),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 48),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESTINATION CARD
  // ============================================================

  Widget _buildPlaceCard(BuildContext context, PlaceItem place) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _openDestination(context, place);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ------------------------------------------------------
                // DESTINATION IMAGE
                // ------------------------------------------------------
                Image.asset(
                  place.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: primaryColor,
                      child: Center(
                        child: Icon(
                          Icons.landscape_outlined,
                          size: 48,
                          color: Colors.white.withValues(alpha: 0.60),
                        ),
                      ),
                    );
                  },
                ),

                // ------------------------------------------------------
                // IMAGE OVERLAY
                // ------------------------------------------------------
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.15),
                        Colors.black.withValues(alpha: 0.78),
                      ],
                      stops: const [0.0, 0.48, 1.0],
                    ),
                  ),
                ),

                // ------------------------------------------------------
                // CARD CONTENT
                // ------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              place.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.92),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // ------------------------------------------------
                      // ARROW
                      // ------------------------------------------------
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.88),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.30),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: backgroundColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESTINATION NAVIGATION
  // ============================================================

  void _openDestination(BuildContext context, PlaceItem place) {
    // Keep the navigation that already exists in the project.

    final title = place.title.trim().toLowerCase();

    if (title == 'anuradhapura') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationPage(destination: anuradhapura),
        ),
      );
      return;
    }

    if (title == 'polonnaruwa') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationPage(destination: polonnaruwa),
        ),
      );

      return;
    }

    if (title == 'jaffna') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationPage(destination: jaffna),
        ),
      );

      return;
    }

    if (title == 'down south') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationPage(destination: downSouth),
        ),
      );

      return;
    }

    if (title == 'kandy') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationPage(destination: kandy),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Exploring ${place.title}...',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ============================================================
  // NAVIGATION HANDLER
  // ============================================================

  void _handleNavigation(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
      return;
    }

    if (index == 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          index == 1
              ? 'Services will be connected next.'
              : 'Saved will be connected next.',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
