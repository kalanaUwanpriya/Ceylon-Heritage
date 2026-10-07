import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/place_details_screen.dart';
import 'services/service_data.dart';
import 'saved_places_service.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final SavedPlacesService _savedPlacesService = SavedPlacesService();

  List<String> firebaseSavedPlaceIds = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPlaces();
  }

  Future<void> _loadSavedPlaces() async {
    final placeIds = await _savedPlacesService.getSavedPlaceIds();

    if (!mounted) return;

    setState(() {
      firebaseSavedPlaceIds = placeIds;
    });
  }

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);

  String selectedCategory = 'All';
  String searchQuery = '';
  bool isSearching = false;

  List<Map<String, dynamic>> get savedItems {
    final List<Map<String, dynamic>> items = [];

    const cities = [
      'Anuradhapura',
      'Polonnaruwa',
      'Kandy',
      'Jaffna',
      'Down South',
      'Dambulla',
    ];

    const categories = [
      'Accommodation',
      'Food & Restaurants',
      'Parking',
      'Health Services',
    ];

    for (final city in cities) {
      for (final category in categories) {
        final places = ServiceData.getPlaces(city, category);

        for (final place in places) {
          if (firebaseSavedPlaceIds.contains(place.name)) {
            items.add({
              'title': place.name,
              'location': city,
              'type': 'Services',
              'category': category,
              'subtitle': category,
              'image': place.imagePath,
            });
          }
        }
      }
    }

    return items;
  }

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> items = List.from(savedItems);
    // Category filter
    if (selectedCategory != 'All') {
      items = items.where((item) => item['type'] == selectedCategory).toList();
    }

    // Search filter
    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();

      items = items.where((item) {
        final title = item['title'].toString().toLowerCase();
        final location = item['location'].toString().toLowerCase();
        final subtitle = item['subtitle'].toString().toLowerCase();

        return title.contains(query) ||
            location.contains(query) ||
            subtitle.contains(query);
      }).toList();
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= HEADER =================
                    Row(
                      children: [
                        if (isSearching)
                          Expanded(
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextField(
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: primaryGreen,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search saved items...',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: primaryGreen.withValues(alpha: 0.55),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: primaryGreen,
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: Text(
                              'Saved',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                          ),

                        const SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSearching) {
                                searchQuery = '';
                              }

                              isSearching = !isSearching;
                            });
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              isSearching ? Icons.close : Icons.search,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Your favourite routes and places, all in one place.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: primaryGreen.withValues(alpha: 0.70),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ================= FILTERS =================
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildFilterButton('All'),
                          _buildFilterButton('Routes'),
                          _buildFilterButton('Historical Places'),
                          _buildFilterButton('Services'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ================= TITLE =================
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 21,
                          color: primaryGreen,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            selectedCategory == 'All'
                                ? 'All Saved'
                                : 'Saved $selectedCategory',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                        Text(
                          '${filteredItems.length} items',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: primaryGreen.withValues(alpha: 0.65),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ================= SAVED ITEMS =================
                    if (filteredItems.isEmpty)
                      _buildEmptyState()
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.82,
                            ),
                        itemBuilder: (context, index) {
                          return _buildSavedCard(filteredItems[index]);
                        },
                      ),
                  ],
                ),
              ),
            ),

            // ================= BOTTOM NAVIGATION =================
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FILTER BUTTON
  // ============================================================

  Widget _buildFilterButton(String title) {
    final bool isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? primaryGreen : cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? backgroundColor : primaryGreen,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SAVED CARD
  // ============================================================
  Future<void> _openSavedItem(Map<String, dynamic> item) async {
    if (item['type'] == 'Services') {
      final places = ServiceData.getPlaces(item['location'], item['category']);

      final matches = places.where((place) => place.name == item['title']);

      if (matches.isNotEmpty) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailsScreen(place: matches.first),
          ),
        );

        // Reload saved places after coming back
        await _loadSavedPlaces();
      }
    }
  }

  Widget _buildSavedCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _openSavedItem(item);
      },
      child: Container(
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

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        item['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE7D2B5),
                            child: const Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: primaryGreen,
                                size: 36,
                              ),
                            ),
                          );
                        },
                      ),

                      // CATEGORY LABEL
                      Positioned(
                        top: 7,
                        left: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _shortCategory(item['type']),
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // DETAILS
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 3, 11, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: primaryGreen,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.more_horiz,
                        size: 18,
                        color: primaryGreen,
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: accentColor,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          item['location'],
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

                  const SizedBox(height: 4),

                  Text(
                    item['subtitle'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: primaryGreen.withValues(alpha: 0.60),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 50,
            color: primaryGreen.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 12),
          Text(
            'No saved items yet',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: primaryGreen,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Items you save will appear here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: primaryGreen.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }

  String _shortCategory(String type) {
    if (type == 'Historical Places') {
      return 'Historical';
    }

    return type;
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8EEDF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
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
            _buildNavItem(icon: Icons.home_outlined, label: 'Home'),
            _buildNavItem(icon: Icons.grid_view_rounded, label: 'Services'),
            _buildNavItem(icon: Icons.favorite, label: 'Saved', isActive: true),
            _buildNavItem(icon: Icons.person_outline, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isActive = false,
  }) {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: backgroundColor),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: backgroundColor,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: primaryGreen),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}
