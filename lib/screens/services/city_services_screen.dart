import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'service_places_screen.dart';
import 'firestore_services_repository.dart';
import 'services_screen.dart';
import '../home_screen.dart';
import '../saved_places_screen.dart';
import '../profile_screen.dart';

class CityServicesScreen extends StatelessWidget {
  final String cityName;
  final String imagePath;
  final bool isNetworkImage;

  const CityServicesScreen({
    super.key,
    required this.cityName,
    required this.imagePath,
    this.isNetworkImage = false,
  });

  // ================= DESIGN SYSTEM COLORS =================
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryGreen = Color(0xFF17452F);

  // Updated card color
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 14, 12, 22),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==========================================
                      // TOP BAR
                      // ==========================================
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: primaryGreen,
                              size: 25,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              'Services',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,

                                // BOLD
                                fontWeight: FontWeight.w700,

                                color: primaryGreen,
                              ),
                            ),
                          ),

                          const SizedBox(width: 48),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // ==========================================
                      // CITY IMAGE
                      // ==========================================
                      // ================= CITY IMAGE =================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          width: double.infinity,
                          height: 185,
                          child: isNetworkImage
                              ? Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      _buildCityImagePlaceholder(),
                                )
                              : Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      _buildCityImagePlaceholder(),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ==========================================
                      // CITY HEADING
                      // ==========================================
                      Text(
                        'Services in $cityName',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,

                          // BOLD
                          fontWeight: FontWeight.w700,

                          color: primaryGreen,
                          height: 1.15,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ==========================================
                      // DESCRIPTION
                      // ==========================================
                      Text(
                        'Find essential services and facilities to make '
                        'your visit comfortable and convenient.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryGreen.withValues(alpha: 0.78),
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Keep the four built-in categories and add new
                      // active Firestore categories in real time.
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream: FirestoreServicesRepository.watchCategories(),
                        builder: (context, snapshot) {
                          final categories = <_ServiceCategory>[
                            const _ServiceCategory(
                              name: 'Accommodation',
                              description:
                                  'Find the best places to stay for a comfortable and memorable visit.',
                              icon: Icons.hotel_outlined,
                            ),
                            const _ServiceCategory(
                              name: 'Food & Restaurants',
                              description:
                                  'Discover local restaurants and enjoy a variety of delicious cuisines.',
                              icon: Icons.restaurant_outlined,
                            ),
                            const _ServiceCategory(
                              name: 'Parking',
                              description:
                                  'Find convenient parking areas near popular attractions and your location.',
                              icon: Icons.local_parking_outlined,
                            ),
                            const _ServiceCategory(
                              name: 'Health Services',
                              description:
                                  'Access medical facilities and health services for a safe and worry-free visit.',
                              icon: Icons.local_hospital_outlined,
                            ),
                          ];

                          if (snapshot.hasData) {
                            for (final data in snapshot.data!) {
                              // Show Firebase categories only in assigned cities.
                              // Built-in categories above remain available everywhere.
                              final assignedCities = data['cities'];
                              final isAssigned =
                                  assignedCities is List &&
                                  assignedCities.any(
                                    (city) =>
                                        city.toString().trim().toLowerCase() ==
                                        cityName.trim().toLowerCase(),
                                  );
                              if (!isAssigned) {
                                continue;
                              }

                              final name = (data['name'] ?? '')
                                  .toString()
                                  .trim();
                              if (name.isEmpty ||
                                  categories.any(
                                    (category) =>
                                        category.name.toLowerCase() ==
                                        name.toLowerCase(),
                                  )) {
                                continue;
                              }

                              final description = (data['description'] ?? '')
                                  .toString()
                                  .trim();
                              categories.add(
                                _ServiceCategory(
                                  name: name,
                                  description: description.isEmpty
                                      ? 'Explore $name services in $cityName.'
                                      : description,
                                  icon: _iconForCategory(name),
                                ),
                              );
                            }
                          }

                          return Column(
                            children: [
                              for (var i = 0; i < categories.length; i++) ...[
                                if (i > 0) const SizedBox(height: 10),
                                _buildServiceCard(
                                  icon: categories[i].icon,
                                  title: categories[i].name,
                                  description: categories[i].description,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServicePlacesScreen(
                                              cityName: cityName,
                                              category: categories[i].name,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ==========================================
            // BOTTOM NAVIGATION
            // ==========================================
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCityImagePlaceholder() {
    return Container(
      color: cardColor,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 45, color: primaryGreen),
      ),
    );
  }

  static IconData _iconForCategory(String name) {
    final value = name.toLowerCase();
    if (value.contains('food') || value.contains('restaurant')) {
      return Icons.restaurant_outlined;
    }
    if (value.contains('hotel') ||
        value.contains('stay') ||
        value.contains('accommodation')) {
      return Icons.hotel_outlined;
    }
    if (value.contains('park')) return Icons.local_parking_outlined;
    if (value.contains('health') ||
        value.contains('medical') ||
        value.contains('hospital')) {
      return Icons.local_hospital_outlined;
    }
    if (value.contains('transport') || value.contains('taxi')) {
      return Icons.directions_car_outlined;
    }
    return Icons.category_outlined;
  }

  // ============================================================
  // SERVICE CARD
  // ============================================================
  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),

        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),

            boxShadow: [
              BoxShadow(
                color: primaryGreen.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              // ========================================
              // ICON
              // ========================================
              Container(
                width: 48,
                height: 48,

                decoration: const BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),

                child: Icon(icon, size: 25, color: accentColor),
              ),

              const SizedBox(width: 12),

              // ========================================
              // TEXT
              // ========================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,

                        // BOLD SERVICE HEADINGS
                        fontWeight: FontWeight.w700,

                        color: primaryGreen,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,

                        color: primaryGreen.withValues(alpha: 0.78),

                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ========================================
              // ARROW BUTTON
              // ========================================
              Container(
                width: 36,
                height: 36,

                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================
  void _navigateToBottomPage(BuildContext context, String label) {
    Widget? page;

    switch (label) {
      case 'Home':
        page = const HomeScreen();
        break;

      case 'Services':
        page = const ServicesScreen();
        break;

      case 'Saved':
        page = const SavedPlacesScreen();
        break;

      case 'Profile':
        page = const ProfileScreen();
        break;
    }

    if (page != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => page!),
        (route) => route.isFirst,
      );
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      decoration: BoxDecoration(
        color: backgroundColor,

        boxShadow: [
          BoxShadow(
            color: primaryGreen.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            _buildNavItem(icon: Icons.home_outlined, label: 'Home'),

            _buildNavItem(
              icon: Icons.grid_view_rounded,
              label: 'Services',
              selected: true,
            ),

            _buildNavItem(icon: Icons.favorite_border_rounded, label: 'Saved'),

            _buildNavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAV ITEM
  // ============================================================
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool selected = false,
  }) {
    return Builder(
      builder: (context) {
        return InkWell(
          onTap: () => _navigateToBottomPage(context, label),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? primaryGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: selected ? backgroundColor : primaryGreen,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: selected ? backgroundColor : primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// UI-only category data; existing Firestore repository remains unchanged.
class _ServiceCategory {
  final String name;
  final String description;
  final IconData icon;

  const _ServiceCategory({
    required this.name,
    required this.description,
    required this.icon,
  });
}
