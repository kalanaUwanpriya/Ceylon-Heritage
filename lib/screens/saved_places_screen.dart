import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/place_lookup.dart';
import '../models/destination.dart';
import '../services/saved_places_service.dart';
import '../widgets/app_navigation_bar.dart';
import 'home_screen.dart';
import 'plan/walking_tour_route_page.dart';
import 'profile_screen.dart';
import 'services/place_details_screen.dart';
import 'services/service_data.dart';

/// Categories for filtering saved items.
enum SavedCategory { all, routes, places, services }

class SavedPlacesScreen extends StatefulWidget {
  final SavedCategory initialCategory;

  const SavedPlacesScreen({
    super.key,
    this.initialCategory = SavedCategory.all,
  });

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  final SavedPlacesService _service = SavedPlacesService();
  final TextEditingController _searchController = TextEditingController();

  late SavedCategory _selectedCategory;
  bool _isSearching = false;
  String _searchQuery = '';

  // Ceylon Heritage design system colors
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color darkGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color borderColor = Color(0xFFE1D2BD);
  static const Color textColor = Color(0xFF303530);
  static const Color secondaryTextColor = Color(0xFF5F625D);
  static const Color unselectedTabBg = Color(0xFFECE0D1);

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleNavigation(int index) {
    AppNavigationBar.handleNavigation(context, index, currentIndex: 2);
  }

  Future<void> _removePlace(SavedPlaceModel place) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _service.removeSavedPlace(place.destinationId);
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      final label = place.isTour
          ? 'Route'
          : (place.isService ? 'Service' : 'Place');
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '$label removed from saved.',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: darkGreen,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Failed to remove: $e',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _openItem(SavedPlaceModel place) {
    if (place.isTour) {
      _navigateToRoute(place);
    } else if (place.isService) {
      _navigateToService(place);
    } else {
      _navigateToPlace(place);
    }
  }

  void _navigateToRoute(SavedPlaceModel place) {
    final params = place.decodedTourParams;
    final destName = params?['destinationName'] as String? ?? 'Anuradhapura';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalkingTourRoutePage(
          tempo: params?['tempo'] as String? ?? 'Moderate',
          timeAvailable: params?['timeAvailable'] as String? ?? '1 Day',
          ratingFilter: params?['ratingFilter'] as String? ?? 'Any',
          destination: Destination(
            name: destName,
            location: '$destName, Sri Lanka',
            description: '',
            image: place.destinationImage,
            popularAttractions: const [],
          ),
        ),
      ),
    );
  }

  void _navigateToService(SavedPlaceModel place) {
    ServicePlace? servicePlace;
    final data = place.decodedServiceData;
    if (data != null) {
      servicePlace = ServicePlace.fromMap(data);
    } else {
      servicePlace = ServiceData.findPlaceByName(place.destinationName);
    }
    servicePlace ??= ServicePlace(
      name: place.destinationName,
      type: (place.category != null && place.category!.isNotEmpty)
          ? place.category!
          : 'Service',
      location: place.location,
      description: place.description,
      mapUrl: '',
      imagePath: place.destinationImage,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsScreen(place: servicePlace!),
      ),
    );
  }

  void _navigateToPlace(SavedPlaceModel place) {
    final lookup = PlaceLookup.lookup(place.destinationId);
    if (lookup.pageBuilder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: lookup.pageBuilder!),
      );
    }
  }

  void _showItemOptions(SavedPlaceModel place) {
    final categoryLabel = place.isTour
        ? 'Route'
        : (place.isService
            ? (place.category?.isNotEmpty == true ? place.category! : 'Service')
            : 'Historical Place');

    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: _buildImageWidget(place.destinationImage),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.destinationName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            categoryLabel,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.open_in_new_rounded,
                      color: darkGreen,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'View Details',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: darkGreen,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _openItem(place);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade700,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Remove from Saved',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _removePlace(place);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openCategoryView(SavedCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedCategoryViewScreen(
          category: category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: user == null
          ? _buildUnauthenticatedState()
          : _buildSavedStreamContent(),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: 2,
        onDestinationSelected: _handleNavigation,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (_isSearching) {
      return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: darkGreen,
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchQuery = '';
              _searchController.clear();
            });
          },
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: GoogleFonts.inter(color: textColor, fontSize: 15),
          cursorColor: darkGreen,
          decoration: InputDecoration(
            hintText: 'Search saved items...',
            hintStyle:
                GoogleFonts.inter(color: secondaryTextColor, fontSize: 15),
            border: InputBorder.none,
          ),
          onChanged: (val) {
            setState(() {
              _searchQuery = val.trim();
            });
          },
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon:
                  const Icon(Icons.close_rounded, color: darkGreen, size: 20),
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _searchController.clear();
                });
              },
            ),
        ],
      );
    }

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: darkGreen,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        'Saved',
        style: GoogleFonts.playfairDisplay(
          color: darkGreen,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            color: darkGreen,
            size: 24,
          ),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildUnauthenticatedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: borderColor.withAlpha(80),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                size: 40,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Sign In to View Saved Items',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Log in with your account to access your saved walking routes, places, and services anytime.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: secondaryTextColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                'Go to Profile',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedStreamContent() {
    return StreamBuilder<List<SavedPlaceModel>>(
      stream: _service.watchSavedPlaces(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: darkGreen),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: accentColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Unable to load saved items.',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final allSaved = snapshot.data ?? [];

        // Calculate counts from real Firestore data
        final allCount = allSaved.length;
        final routes = allSaved.where((p) => p.isTour).toList();
        final places = allSaved.where((p) => !p.isTour && !p.isService).toList();
        final services = allSaved.where((p) => p.isService).toList();

        final routesCount = routes.length;
        final placesCount = places.length;
        final servicesCount = services.length;

        // Apply search filter if query is present
        List<SavedPlaceModel> filteredAll = allSaved;
        List<SavedPlaceModel> filteredRoutes = routes;
        List<SavedPlaceModel> filteredPlaces = places;
        List<SavedPlaceModel> filteredServices = services;

        if (_searchQuery.isNotEmpty) {
          final q = _searchQuery.toLowerCase();
          bool matches(SavedPlaceModel item) =>
              item.destinationName.toLowerCase().contains(q) ||
              item.location.toLowerCase().contains(q) ||
              (item.category ?? '').toLowerCase().contains(q);

          filteredAll = allSaved.where(matches).toList();
          filteredRoutes = routes.where(matches).toList();
          filteredPlaces = places.where(matches).toList();
          filteredServices = services.where(matches).toList();
        }

        if (allSaved.isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 12),
              child: Text(
                'Your important routes, places and services, all in one place.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: secondaryTextColor,
                  height: 1.35,
                ),
              ),
            ),

            // Filter Tabs Row
            _buildFilterTabs(
              allCount: allCount,
              routesCount: routesCount,
              placesCount: placesCount,
              servicesCount: servicesCount,
            ),

            const SizedBox(height: 12),

            // Tab Content
            Expanded(
              child: _buildTabContent(
                all: filteredAll,
                routes: filteredRoutes,
                places: filteredPlaces,
                services: filteredServices,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterTabs({
    required int allCount,
    required int routesCount,
    required int placesCount,
    required int servicesCount,
  }) {
    final firstRowTabs = [
      (
        category: SavedCategory.all,
        label: 'All ($allCount)',
        icon: Icons.grid_view_rounded,
      ),
      (
        category: SavedCategory.routes,
        label: 'Routes ($routesCount)',
        icon: Icons.alt_route_rounded,
      ),
      (
        category: SavedCategory.places,
        label: 'Places ($placesCount)',
        icon: Icons.place_outlined,
      ),
    ];

    Widget buildChip({
      required SavedCategory category,
      required String label,
      required IconData icon,
    }) {
      final isSelected = _selectedCategory == category;
      return InkWell(
        onTap: () => setState(() => _selectedCategory = category),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? darkGreen : unselectedTabBg,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : darkGreen,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.white : darkGreen,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: firstRowTabs.map((tab) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: buildChip(
                  category: tab.category,
                  label: tab.label,
                  icon: tab.icon,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: buildChip(
            category: SavedCategory.services,
            label: 'Services ($servicesCount)',
            icon: Icons.grid_view_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent({
    required List<SavedPlaceModel> all,
    required List<SavedPlaceModel> routes,
    required List<SavedPlaceModel> places,
    required List<SavedPlaceModel> services,
  }) {
    if (_searchQuery.isNotEmpty &&
        ((_selectedCategory == SavedCategory.all && all.isEmpty) ||
            (_selectedCategory == SavedCategory.routes && routes.isEmpty) ||
            (_selectedCategory == SavedCategory.places && places.isEmpty) ||
            (_selectedCategory == SavedCategory.services && services.isEmpty))) {
      return _buildSearchEmptyState();
    }

    switch (_selectedCategory) {
      case SavedCategory.all:
        return _buildAllSections(
          routes: routes,
          places: places,
          services: services,
        );
      case SavedCategory.routes:
        return _buildRoutesOnly(routes);
      case SavedCategory.places:
        return _buildPlacesOnly(places);
      case SavedCategory.services:
        return _buildServicesOnly(services);
    }
  }

  // ── "All" Tab: Shows Routes, Places, Services with See All ─────────────
  Widget _buildAllSections({
    required List<SavedPlaceModel> routes,
    required List<SavedPlaceModel> places,
    required List<SavedPlaceModel> services,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saved Routes Section
          if (routes.isNotEmpty) ...[
            _buildSectionHeader(
              icon: Icons.alt_route_rounded,
              title: 'Saved Routes',
              count: routes.length,
              onSeeAll: () => _openCategoryView(SavedCategory.routes),
            ),
            ...routes.take(4).map(_buildRouteCard),
            const SizedBox(height: 12),
          ],

          // Saved Places Section
          if (places.isNotEmpty) ...[
            _buildSectionHeader(
              icon: Icons.favorite_border_rounded,
              title: 'Saved Places',
              count: places.length,
              onSeeAll: () => _openCategoryView(SavedCategory.places),
            ),
            _buildPlacesGrid(places.take(6).toList()),
            const SizedBox(height: 16),
          ],

          // Saved Services Section
          if (services.isNotEmpty) ...[
            _buildSectionHeader(
              icon: Icons.grid_view_rounded,
              title: 'Saved Services',
              count: services.length,
              onSeeAll: () => _openCategoryView(SavedCategory.services),
            ),
            _buildServicesGrid(services.take(4).toList()),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildRoutesOnly(List<SavedPlaceModel> routes) {
    if (routes.isEmpty) {
      return _buildCategoryEmptyState(
        icon: Icons.alt_route_rounded,
        title: 'No Saved Routes',
        subtitle: 'Save a walking route from the walking plan to access it here.',
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: routes.length,
      itemBuilder: (context, index) => _buildRouteCard(routes[index]),
    );
  }

  Widget _buildPlacesOnly(List<SavedPlaceModel> places) {
    if (places.isEmpty) {
      return _buildCategoryEmptyState(
        icon: Icons.favorite_border_rounded,
        title: 'No Saved Places',
        subtitle: 'Save historical places to view them here.',
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: _buildPlacesGrid(places),
    );
  }

  Widget _buildServicesOnly(List<SavedPlaceModel> services) {
    if (services.isEmpty) {
      return _buildCategoryEmptyState(
        icon: Icons.grid_view_rounded,
        title: 'No Saved Services',
        subtitle: 'Save individual services from the services category pages to view them here.',
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: _buildServicesGrid(services),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required int count,
    required VoidCallback onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: darkGreen),
          const SizedBox(width: 6),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: darkGreen,
            ),
          ),
          Text(
            ' ($count)',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: secondaryTextColor,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkGreen,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: darkGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Route Card (Horizontal Tile) ──────────────────────────────────────
  Widget _buildRouteCard(SavedPlaceModel place) {
    return GestureDetector(
      onTap: () => _openItem(place),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor.withAlpha(120), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 82,
                height: 52,
                child: _buildImageWidget(place.destinationImage),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                place.destinationName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: darkGreen,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showItemOptions(place),
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_horiz_rounded,
                  size: 20,
                  color: secondaryTextColor,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: secondaryTextColor,
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  // ── Places Grid (3 columns as in reference screenshot) ────────────────
  Widget _buildPlacesGrid(List<SavedPlaceModel> places) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 600 ? 4 : 3;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: places.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: 0.76,
          ),
          itemBuilder: (context, index) {
            return _buildPlaceGridCard(places[index]);
          },
        );
      },
    );
  }

  Widget _buildPlaceGridCard(SavedPlaceModel place) {
    return GestureDetector(
      onTap: () => _openItem(place),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor.withAlpha(120), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: AspectRatio(
                aspectRatio: 1.35,
                child: _buildImageWidget(place.destinationImage),
              ),
            ),
            const SizedBox(height: 6),
            // Title + Options
            Row(
              children: [
                Expanded(
                  child: Text(
                    place.destinationName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: darkGreen,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showItemOptions(place),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(
                      Icons.more_horiz_rounded,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Location + Chevron
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 11,
                  color: secondaryTextColor,
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    place.location.isNotEmpty ? place.location : 'Sri Lanka',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: secondaryTextColor,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 14,
                  color: secondaryTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Services Grid (as in reference screenshot) ─────────────────────────
  Widget _buildServicesGrid(List<SavedPlaceModel> services) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 600 ? 4 : 3;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            return _buildServiceGridCard(services[index]);
          },
        );
      },
    );
  }

  Widget _buildServiceGridCard(SavedPlaceModel place) {
    return GestureDetector(
      onTap: () => _openItem(place),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor.withAlpha(120), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: AspectRatio(
                aspectRatio: 1.35,
                child: _buildImageWidget(place.destinationImage),
              ),
            ),
            const SizedBox(height: 6),
            // Title + Options + Chevron
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      place.destinationName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showItemOptions(place),
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.more_horiz_rounded,
                        size: 15,
                        color: secondaryTextColor,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 14,
                    color: secondaryTextColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: borderColor.withAlpha(80),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                size: 42,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No Saved Items Yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Explore ancient cities, walking routes, and nearby services. Tap the save icon on any item to access it here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: secondaryTextColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                'Explore Destinations',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: borderColor.withAlpha(80),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: accentColor),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: secondaryTextColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: secondaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No Results Found',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No saved items match "$_searchQuery".',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(String path) {
    if (path.isEmpty) return _buildImageFallback();
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
    );
  }

  Widget _buildImageFallback() {
    return Container(
      color: borderColor.withAlpha(120),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          color: darkGreen,
          size: 24,
        ),
      ),
    );
  }
}

/// Dedicated full-page view for each category triggered by "See All"
class SavedCategoryViewScreen extends StatefulWidget {
  final SavedCategory category;

  const SavedCategoryViewScreen({
    super.key,
    required this.category,
  });

  @override
  State<SavedCategoryViewScreen> createState() =>
      _SavedCategoryViewScreenState();
}

class _SavedCategoryViewScreenState extends State<SavedCategoryViewScreen> {
  final SavedPlacesService _service = SavedPlacesService();
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  String _searchQuery = '';

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color darkGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color borderColor = Color(0xFFE1D2BD);
  static const Color textColor = Color(0xFF303530);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.category) {
      case SavedCategory.routes:
        return 'Saved Routes';
      case SavedCategory.places:
        return 'Saved Places';
      case SavedCategory.services:
        return 'Saved Services';
      case SavedCategory.all:
        return 'All Saved Items';
    }
  }

  void _openItem(SavedPlaceModel place) {
    if (place.isTour) {
      final params = place.decodedTourParams;
      final destName = params?['destinationName'] as String? ?? 'Anuradhapura';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WalkingTourRoutePage(
            tempo: params?['tempo'] as String? ?? 'Moderate',
            timeAvailable: params?['timeAvailable'] as String? ?? '1 Day',
            ratingFilter: params?['ratingFilter'] as String? ?? 'Any',
            destination: Destination(
              name: destName,
              location: '$destName, Sri Lanka',
              description: '',
              image: place.destinationImage,
              popularAttractions: const [],
            ),
          ),
        ),
      );
    } else if (place.isService) {
      ServicePlace? servicePlace;
      final data = place.decodedServiceData;
      if (data != null) {
        servicePlace = ServicePlace.fromMap(data);
      } else {
        servicePlace = ServiceData.findPlaceByName(place.destinationName);
      }
      servicePlace ??= ServicePlace(
        name: place.destinationName,
        type: (place.category != null && place.category!.isNotEmpty)
            ? place.category!
            : 'Service',
        location: place.location,
        description: place.description,
        mapUrl: '',
        imagePath: place.destinationImage,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceDetailsScreen(place: servicePlace!),
        ),
      );
    } else {
      final lookup = PlaceLookup.lookup(place.destinationId);
      if (lookup.pageBuilder != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: lookup.pageBuilder!),
        );
      }
    }
  }

  Future<void> _removePlace(SavedPlaceModel place) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _service.removeSavedPlace(place.destinationId);
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Item removed from saved.',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: darkGreen,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Failed to remove: $e',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showItemOptions(SavedPlaceModel place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.open_in_new_rounded,
                      color: darkGreen,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'View Details',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: darkGreen,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _openItem(place);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade700,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Remove from Saved',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _removePlace(place);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: darkGreen,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: GoogleFonts.inter(color: textColor, fontSize: 15),
                cursorColor: darkGreen,
                decoration: InputDecoration(
                  hintText: 'Search $_title...',
                  hintStyle: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
              )
            : Text(
                _title,
                style: GoogleFonts.playfairDisplay(
                  color: darkGreen,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close_rounded : Icons.search_rounded,
              color: darkGreen,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: StreamBuilder<List<SavedPlaceModel>>(
        stream: _service.watchSavedPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: darkGreen),
            );
          }

          final all = snapshot.data ?? [];
          List<SavedPlaceModel> items;

          switch (widget.category) {
            case SavedCategory.routes:
              items = all.where((p) => p.isTour).toList();
              break;
            case SavedCategory.places:
              items = all.where((p) => !p.isTour && !p.isService).toList();
              break;
            case SavedCategory.services:
              items = all.where((p) => p.isService).toList();
              break;
            case SavedCategory.all:
              items = all;
              break;
          }

          if (_searchQuery.isNotEmpty) {
            final q = _searchQuery.toLowerCase();
            items = items
                .where((p) =>
                    p.destinationName.toLowerCase().contains(q) ||
                    p.location.toLowerCase().contains(q) ||
                    (p.category ?? '').toLowerCase().contains(q))
                .toList();
          }

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bookmark_border_rounded,
                      size: 48,
                      color: accentColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _searchQuery.isNotEmpty
                          ? 'No Results Found'
                          : 'No Items in $_title',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _searchQuery.isNotEmpty
                          ? 'No items match "$_searchQuery".'
                          : 'You have not saved any items in this category yet.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (widget.category == SavedCategory.routes) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final place = items[index];
                return GestureDetector(
                  onTap: () => _openItem(place),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: borderColor.withAlpha(120),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 82,
                            height: 52,
                            child: _buildImage(place.destinationImage),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            place.destinationName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: darkGreen,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showItemOptions(place),
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.more_horiz_rounded,
                              size: 20,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: secondaryTextColor,
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // Grid for Places and Services
          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth >= 600 ? 4 : 3;
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  childAspectRatio:
                      widget.category == SavedCategory.places ? 0.76 : 0.85,
                ),
                itemBuilder: (context, index) {
                  final place = items[index];
                  return GestureDetector(
                    onTap: () => _openItem(place),
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: borderColor.withAlpha(120),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: AspectRatio(
                              aspectRatio: 1.35,
                              child: _buildImage(place.destinationImage),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  place.destinationName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: darkGreen,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _showItemOptions(place),
                                behavior: HitTestBehavior.opaque,
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    size: 16,
                                    color: secondaryTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (widget.category == SavedCategory.places)
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 11,
                                  color: secondaryTextColor,
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    place.location.isNotEmpty
                                        ? place.location
                                        : 'Sri Lanka',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 14,
                                  color: secondaryTextColor,
                                ),
                              ],
                            )
                          else
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.chevron_right_rounded,
                                size: 14,
                                color: secondaryTextColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildImage(String path) {
    if (path.isEmpty) {
      return Container(
        color: borderColor.withAlpha(120),
        child: const Icon(Icons.image_outlined, color: darkGreen, size: 24),
      );
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: borderColor.withAlpha(120),
          child: const Icon(Icons.image_outlined, color: darkGreen, size: 24),
        ),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: borderColor.withAlpha(120),
        child: const Icon(Icons.image_outlined, color: darkGreen, size: 24),
      ),
    );
  }
}
