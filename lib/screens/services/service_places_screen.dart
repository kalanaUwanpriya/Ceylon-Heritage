import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'service_data.dart';

import 'place_details_screen.dart';
import '../home_screen.dart';
import '../profile_screen.dart';
import '../saved_places_screen.dart';
import 'services_screen.dart';
import 'firestore_services_repository.dart';

class ServicePlacesScreen extends StatefulWidget {
  final String cityName;

  final String category;

  const ServicePlacesScreen({
    super.key,

    required this.cityName,

    required this.category,
  });

  @override
  State<ServicePlacesScreen> createState() => _ServicePlacesScreenState();
}

class _ServicePlacesScreenState extends State<ServicePlacesScreen> {
  static const Color backgroundColor = Color(0xFFF6EADA);

  static const Color primaryGreen = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color accentColor = Color(0xFF9F5625);

  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  // ---------------------------------------------------------

  // CATEGORY ICON

  // ---------------------------------------------------------

  IconData get _categoryIcon {
    switch (widget.category) {
      case 'Accommodation':
        return Icons.hotel_outlined;

      case 'Food & Restaurants':
        return Icons.restaurant_outlined;

      case 'Parking':
        return Icons.local_parking_outlined;

      case 'Health Services':
        return Icons.local_hospital_outlined;

      default:
        return Icons.place_outlined;
    }
  }

  // ---------------------------------------------------------

  // DESCRIPTION

  // ---------------------------------------------------------

  String get _description {
    switch (widget.category) {
      case 'Accommodation':
        return 'Find the best places to stay for a comfortable and memorable visit.';

      case 'Food & Restaurants':
        return 'Discover great places to enjoy local food and delicious meals.';

      case 'Parking':
        return 'Find convenient parking areas near popular attractions and city locations.';

      case 'Health Services':
        return 'Find nearby hospitals and medical services for a safe and comfortable journey.';

      default:
        return 'Explore useful services available in this area.';
    }
  }

  // ---------------------------------------------------------

  // FILTERS

  // ---------------------------------------------------------

  List<String> get _filters {
    switch (widget.category) {
      case 'Accommodation':
        return ['All', 'Hotel', 'Resort'];

      case 'Food & Restaurants':
        return [
          'All',

          'Restaurant',

          'Family Restaurant',

          'Sri Lankan Restaurant',
        ];

      case 'Parking':
        return ['All', 'Parking'];

      case 'Health Services':
        return ['All', 'Hospital', 'Medical Centre'];

      default:
        return ['All'];
    }
  }

  // ---------------------------------------------------------

  // FILTER PLACES

  // ---------------------------------------------------------

  List<ServicePlace> get _filteredPlaces {
    final List<ServicePlace> places = ServiceData.getPlaces(
      widget.cityName,

      widget.category,
    );

    final String searchText = _searchController.text.trim().toLowerCase();

    return places.where((place) {
      final bool matchesSearch =
          searchText.isEmpty ||
          place.name.toLowerCase().contains(searchText) ||
          place.type.toLowerCase().contains(searchText) ||
          place.location.toLowerCase().contains(searchText);

      bool matchesFilter = true;

      if (_selectedFilter != 'All') {
        matchesFilter = place.type.toLowerCase().contains(
          _selectedFilter.toLowerCase(),
        );
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  // ---------------------------------------------------------

  // OPEN GOOGLE MAPS

  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final List<ServicePlace> hardcodedPlaces = _filteredPlaces;

    return Scaffold(
      backgroundColor: backgroundColor,

      // -------------------------------------------------------

      // BODY

      // -------------------------------------------------------
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ServicePlace>>(
                stream: FirestoreServicesRepository.watchPlaces(
                  widget.cityName,
                  widget.category,
                ),
                builder: (context, snapshot) {
                  final firestorePlaces = snapshot.data ?? <ServicePlace>[];

                  final allPlaces = [...hardcodedPlaces, ...firestorePlaces];

                  final searchText = _searchController.text
                      .trim()
                      .toLowerCase();

                  final places = allPlaces.where((place) {
                    final matchesSearch =
                        searchText.isEmpty ||
                        place.name.toLowerCase().contains(searchText) ||
                        place.type.toLowerCase().contains(searchText) ||
                        place.location.toLowerCase().contains(searchText);

                    final matchesFilter =
                        _selectedFilter == 'All' ||
                        place.type.toLowerCase().contains(
                          _selectedFilter.toLowerCase(),
                        );

                    return matchesSearch && matchesFilter;
                  }).toList();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // -------------------------------------------------

                        // TOP BAR

                        // -------------------------------------------------
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              icon: const Icon(
                                Icons.arrow_back,

                                color: primaryGreen,

                                size: 23,
                              ),

                              padding: EdgeInsets.zero,

                              constraints: const BoxConstraints(),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: Text(
                                widget.category,

                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 23,

                                  fontWeight: FontWeight.w700,

                                  color: primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // -------------------------------------------------

                        // SEARCH BAR

                        // -------------------------------------------------
                        Container(
                          height: 50,

                          decoration: BoxDecoration(
                            color: cardColor,

                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: TextField(
                            controller: _searchController,

                            onChanged: (value) {
                              setState(() {});
                            },

                            style: GoogleFonts.inter(
                              fontSize: 14,

                              color: primaryGreen,
                            ),

                            decoration: InputDecoration(
                              hintText: 'Search in ${widget.category}...',

                              hintStyle: GoogleFonts.inter(
                                fontSize: 13,

                                color: primaryGreen.withValues(alpha: 0.60),
                              ),

                              prefixIcon: const Icon(
                                Icons.search,

                                color: primaryGreen,

                                size: 21,
                              ),

                              border: InputBorder.none,

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // -------------------------------------------------

                        // CATEGORY ICON

                        // -------------------------------------------------
                        Center(
                          child: Container(
                            width: 68,

                            height: 68,

                            decoration: BoxDecoration(
                              color: cardColor,

                              shape: BoxShape.circle,
                            ),

                            child: Icon(
                              _categoryIcon,

                              size: 32,

                              color: accentColor,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // -------------------------------------------------

                        // TITLE

                        // -------------------------------------------------
                        Center(
                          child: Text(
                            '${widget.category} in ${widget.cityName}',

                            textAlign: TextAlign.center,

                            style: GoogleFonts.playfairDisplay(
                              fontSize: 23,

                              fontWeight: FontWeight.w700,

                              color: primaryGreen,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // -------------------------------------------------

                        // DESCRIPTION

                        // -------------------------------------------------
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),

                            child: Text(
                              _description,

                              textAlign: TextAlign.center,

                              style: GoogleFonts.inter(
                                fontSize: 13,

                                height: 1.5,

                                color: primaryGreen.withValues(alpha: 0.75),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // -------------------------------------------------

                        // FILTER CHIPS

                        // -------------------------------------------------
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: Row(
                            children: _filters.map((filter) {
                              final bool selected = _selectedFilter == filter;

                              return Padding(
                                padding: const EdgeInsets.only(right: 9),

                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedFilter = filter;
                                    });
                                  },

                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),

                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 17,

                                      vertical: 9,
                                    ),

                                    decoration: BoxDecoration(
                                      color: selected
                                          ? primaryGreen
                                          : cardColor,

                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Text(
                                      filter,

                                      style: GoogleFonts.inter(
                                        fontSize: 12,

                                        fontWeight: FontWeight.w600,

                                        color: selected
                                            ? backgroundColor
                                            : primaryGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // -------------------------------------------------

                        // NO RESULTS

                        // -------------------------------------------------
                        if (places.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 45),

                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,

                                    size: 45,

                                    color: primaryGreen.withValues(alpha: 0.45),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    'No places found',

                                    style: GoogleFonts.inter(
                                      fontSize: 14,

                                      fontWeight: FontWeight.w600,

                                      color: primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        // -------------------------------------------------
                        // PLACE CARDS
                        // -------------------------------------------------
                        else
                          ...places.map((place) => _buildPlaceCard(place)),
                      ],
                    ),
                  );
                },
              ),
            ),

            // -------------------------------------------------------

            // BOTTOM NAVIGATION

            // -------------------------------------------------------
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // =========================================================

  // PLACE CARD

  // =========================================================

  Widget _buildPlaceCard(ServicePlace place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailsScreen(place: place),
          ),
        );
      },
      child: Container(
        width: double.infinity,

        margin: const EdgeInsets.only(bottom: 13),

        padding: const EdgeInsets.all(13),

        decoration: BoxDecoration(
          color: cardColor,

          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),

              blurRadius: 8,

              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            // -------------------------------------------------------

            // IMAGE / PLACEHOLDER

            // -------------------------------------------------------
            ClipRRect(
              borderRadius: BorderRadius.circular(13),

              child: Container(
                width: 82,

                height: 82,

                color: backgroundColor,

                child: place.imagePath.trim().isEmpty
                    ? _buildPlaceholderIcon()
                    : place.imagePath.trim().startsWith('http://') ||
                          place.imagePath.trim().startsWith('https://')
                    ? Image.network(
                        place.imagePath.trim(),
                        fit: BoxFit.cover,
                        width: 82,
                        height: 82,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholderIcon(),
                      )
                    : Image.asset(
                        place.imagePath,
                        fit: BoxFit.cover,
                        width: 82,
                        height: 82,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholderIcon(),
                      ),
              ),
            ),

            const SizedBox(width: 13),

            // -------------------------------------------------------

            // DETAILS

            // -------------------------------------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    place.name,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: GoogleFonts.inter(
                      fontSize: 14,

                      fontWeight: FontWeight.w700,

                      color: primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    place.type,

                    style: GoogleFonts.inter(
                      fontSize: 11,

                      fontWeight: FontWeight.w500,

                      color: accentColor,
                    ),
                  ),

                  if (place.rating != null) ...[
                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,

                          size: 16,

                          color: accentColor,
                        ),

                        const SizedBox(width: 3),

                        Text(
                          place.rating!.toStringAsFixed(1),

                          style: GoogleFonts.inter(
                            fontSize: 11,

                            fontWeight: FontWeight.w600,

                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,

                        size: 14,

                        color: primaryGreen,
                      ),

                      const SizedBox(width: 3),

                      Expanded(
                        child: Text(
                          place.location,

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,

                          style: GoogleFonts.inter(
                            fontSize: 10,

                            color: primaryGreen.withValues(alpha: 0.70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // -------------------------------------------------------

            // MAP BUTTON

            // -------------------------------------------------------
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailsScreen(place: place),
                  ),
                );
              },

              child: Container(
                width: 38,

                height: 38,

                decoration: const BoxDecoration(
                  color: primaryGreen,

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.arrow_forward,

                  size: 19,

                  color: backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================

  // PLACEHOLDER ICON

  // =========================================================

  Widget _buildPlaceholderIcon() {
    return Center(child: Icon(_categoryIcon, size: 30, color: accentColor));
  }

  // =========================================================

  // BOTTOM NAVIGATION

  // =========================================================
  void _navigateToBottomPage(String label) {
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

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),

      decoration: BoxDecoration(
        color: backgroundColor,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),

            blurRadius: 10,

            offset: const Offset(0, -2),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            _navItem(icon: Icons.home_outlined, label: 'Home', selected: false),

            _navItem(
              icon: Icons.grid_view_rounded,

              label: 'Services',

              selected: true,
            ),

            _navItem(
              icon: Icons.favorite_border_rounded,

              label: 'Saved',

              selected: false,
            ),

            _navItem(
              icon: Icons.person_outline_rounded,

              label: 'Profile',

              selected: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    return InkWell(
      onTap: () => _navigateToBottomPage(label),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),

        decoration: BoxDecoration(
          color: selected ? primaryGreen : Colors.transparent,

          borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(
              icon,

              size: 20,

              color: selected ? backgroundColor : primaryGreen,
            ),

            const SizedBox(height: 3),

            Text(
              label,

              style: GoogleFonts.inter(
                fontSize: 10,

                fontWeight: FontWeight.w600,

                color: selected ? backgroundColor : primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
