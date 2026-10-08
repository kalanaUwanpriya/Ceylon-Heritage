import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/historical_places_data.dart';
import '../destinations/destination_page.dart';
import '../widgets/app_navigation_bar.dart';
import 'notification_settings_screen.dart';
import 'profile_screen.dart';
import 'saved_places_screen.dart';
import 'services/services_screen.dart';

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
      title: 'Dambulla',
      subtitle: 'Royal Cave Temple',
      imagePath: 'assets/images/ADambulla.png',
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
              // TOP SECTION WITH BACKGROUND SKETCH BEHIND
              // ==================================================
              Stack(
                children: [
                  // Heritage background sketch illustration fading downwards
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 190,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.50, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Opacity(
                        opacity: 0.38,
                        child: Image.asset(
                          'assets/images/Abackg.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/heritage_sketch_bg.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Header Content
                  _buildHeader(),
                ],
              ),

              const SizedBox(height: 8),

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
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
              border: Border.all(color: primaryColor.withValues(alpha: 0.08)),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationSettingsScreen(),
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

    if (title == 'dambulla') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationPage(destination: dambulla),
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
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ServicesScreen()),
      );
      return;
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SavedPlacesScreen()),
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
          'Services will be connected next.',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
