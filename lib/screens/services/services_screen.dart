import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'city_services_screen.dart';
import 'suggest_service_screen.dart';
import '../home_screen.dart';
import '../profile_screen.dart';
import '../saved_places_screen.dart';
import 'firestore_services_repository.dart';
import '../../widgets/app_navigation_bar.dart';

class ServiceCity {
  final String name;
  final String imagePath;
  final String description;
  final bool isNetworkImage;

  const ServiceCity({
    required this.name,
    required this.imagePath,
    required this.description,
    this.isNetworkImage = false,
  });
}

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // ================= DESIGN SYSTEM COLORS =================
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);

  final List<ServiceCity> _cities = const [
    ServiceCity(
      name: 'Anuradhapura',
      imagePath: 'assets/images/services/anuradhapura.jpg',
      description: 'Explore services and facilities in Anuradhapura.',
    ),
    ServiceCity(
      name: 'Polonnaruwa',
      imagePath: 'assets/images/services/polonnaruwa.jpg',
      description: 'Explore services and facilities in Polonnaruwa.',
    ),
    ServiceCity(
      name: 'Kandy',
      imagePath: 'assets/images/services/kandy.jpg',
      description: 'Explore services and facilities in Kandy.',
    ),
    ServiceCity(
      name: 'Jaffna',
      imagePath: 'assets/images/services/jaffna.jpg',
      description: 'Explore services and facilities in Jaffna.',
    ),
    ServiceCity(
      name: 'Down South',
      imagePath: 'assets/images/services/down_south.jpg',
      description: 'Explore services and facilities in Down South.',
    ),
    ServiceCity(
      name: 'Dambulla',
      imagePath: 'assets/images/services/dambulla.jpg',
      description: 'Explore services and facilities in Dambulla.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ==================================================
            // MAIN CONTENT
            // ==================================================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==================================================
                      // TOP BAR
                      // ==================================================
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.maybePop(context);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),

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

                              // PAGE HEADING
                              // Playfair Display
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: primaryGreen,
                              ),
                            ),
                          ),

                          const SizedBox(width: 25),
                        ],
                      ),

                      const SizedBox(height: 26),

                      // ==================================================
                      // SECTION HEADING
                      // ==================================================
                      Text(
                        'Explore Services',

                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: primaryGreen,
                        ),
                      ),

                      const SizedBox(height: 7),

                      // ==================================================
                      // DESCRIPTION
                      // ==================================================
                      Text(
                        'Choose a city to discover essential services\n'
                        'and facilities for a comfortable visit.',

                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryGreen.withValues(alpha: 0.78),
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ==================================================
                      // SERVICES GRID
                      // ==================================================
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream: FirestoreServicesRepository.watchCities(),
                        builder: (context, snapshot) {
                          final List<ServiceCity> allCities =
                              List<ServiceCity>.from(_cities);

                          if (snapshot.hasData) {
                            for (final data in snapshot.data!) {
                              final name = (data['name'] ?? '')
                                  .toString()
                                  .trim();

                              if (name.isEmpty) continue;

                              // Avoid duplicate cities.
                              final alreadyExists = allCities.any(
                                (city) =>
                                    city.name.toLowerCase() ==
                                    name.toLowerCase(),
                              );

                              if (alreadyExists) continue;

                              final imageUrl = (data['imageUrl'] ?? '')
                                  .toString()
                                  .trim();

                              allCities.add(
                                ServiceCity(
                                  name: name,
                                  imagePath: imageUrl,
                                  description:
                                      (data['description'] ??
                                              'Explore services and facilities in $name.')
                                          .toString(),
                                  isNetworkImage: true,
                                ),
                              );
                            }
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allCities.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 14,
                                  childAspectRatio: 0.80,
                                ),
                            itemBuilder: (context, index) =>
                                _buildCityCard(allCities[index]),
                          ); // GridView.builder
                        },
                      ), // StreamBuilder
                      // ==================================================
                      // SUGGEST SERVICE CARD
                      // ==================================================
                      _buildSuggestServiceCard(),
                    ], // Inner Column children
                  ), // Inner Column
                ), // Padding
              ), // SingleChildScrollView
            ), // Expanded
            // ==================================================
            // BOTTOM NAVIGATION
            // ==================================================
            _buildBottomNavigationBar(),
          ], // Outer Column children
        ), // Outer Column
      ), // SafeArea
    ); // Scaffold
  }

  // ============================================================
  // CITY CARD
  // ============================================================
  Widget _buildSuggestServiceCard() {
    return Container(
      width: double.infinity,
      height: 115,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/services/service_bottom.png',
                fit: BoxFit.cover,
              ),
            ),

            // Text
            Positioned(
              left: 105,
              top: 14,
              right: 14,
              child: Text(
                'Suggest a Service',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: primaryGreen,
                ),
              ),
            ),

            Positioned(
              left: 105,
              top: 40,
              right: 15,
              child: Text(
                'Know a useful place? Help other\ntravellers discover it.',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: primaryGreen.withValues(alpha: 0.82),
                  height: 1.25,
                ),
              ),
            ),

            // Suggest button
            Positioned(
              right: 14,
              bottom: 10,
              child: SizedBox(
                height: 34,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuggestServiceScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: backgroundColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 17),
                  label: Text(
                    'Suggest Service',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityImagePlaceholder() {
    return Container(
      color: backgroundColor,
      child: const Center(
        child: Icon(Icons.image_outlined, color: primaryGreen, size: 35),
      ),
    );
  }

  Widget _buildCityCard(ServiceCity city) {
    return Container(
      decoration: BoxDecoration(
        // Official Card / Secondary colour
        color: cardColor,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: primaryGreen.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),

        child: Material(
          color: cardColor,

          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CityServicesScreen(
                    cityName: city.name,
                    imagePath: city.imagePath,
                    isNetworkImage: city.isNetworkImage,
                  ),
                ),
              );
            },

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================================================
                // CITY IMAGE
                // ==================================================
                Expanded(
                  flex: 5,

                  child: SizedBox(
                    width: double.infinity,

                    child: city.isNetworkImage
                        ? Image.network(
                            city.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildCityImagePlaceholder();
                            },
                          )
                        : Image.asset(
                            city.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildCityImagePlaceholder();
                            },
                          ),
                  ),
                ),

                // ==================================================
                // CARD INFORMATION
                // ==================================================
                Expanded(
                  flex: 4,

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 9, 8, 8),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // ==========================================
                        // CITY NAME
                        // ==========================================
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: accentColor,
                            ),

                            const SizedBox(width: 4),

                            Expanded(
                              child: Text(
                                city.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                // CARD TITLE
                                // Inter 16–18 Semibold
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 7),

                        // ==========================================
                        // DESCRIPTION + BUTTON
                        // ==========================================
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,

                                  child: Text(
                                    city.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,

                                    // BODY TEXT
                                    // Inter 14–16 Regular
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: primaryGreen.withValues(
                                        alpha: 0.82,
                                      ),
                                      height: 1.25,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 5),

                              // ==================================
                              // ARROW BUTTON
                              // ==================================
                              Container(
                                width: 34,
                                height: 34,

                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryGreen,
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
                      ],
                    ),
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
  // BOTTOM NAVIGATION
  // ============================================================
  Widget _buildBottomNavigationBar() {
    return AppNavigationBar(
      selectedIndex: 1,
      onDestinationSelected: (index) {
        AppNavigationBar.handleNavigation(context, index, currentIndex: 1);
      },
    );
  }
}
