import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

import 'service_data.dart';
import 'place_gallery_screen.dart';
import '../saved_places_service.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final ServicePlace place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  bool isFavorite = false;

  bool isSaved = false;

  final SavedPlacesService _savedPlacesService = SavedPlacesService();

  ServicePlace get place => widget.place;

  @override
  void initState() {
    super.initState();
    _loadSavedStatus();
  }

  Future<void> _loadSavedStatus() async {
    final saved = await _savedPlacesService.isPlaceSaved(place.name);

    if (!mounted) return;

    setState(() {
      isSaved = saved;
    });
  }

  static const Color backgroundColor = Color(0xFFF6EADA);

  static const Color primaryGreen = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color accentColor = Color(0xFF9F5625);

  // ---------------------------------------------------------

  // OPEN GOOGLE MAPS

  // ---------------------------------------------------------

  Future<void> _openMap(BuildContext context) async {
    final Uri uri = Uri.parse(place.mapUrl);

    try {
      final bool opened = await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
      );

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open Google Maps')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open Google Maps')),
        );
      }
    }
  }

  // ---------------------------------------------------------

  // CATEGORY ICON

  // ---------------------------------------------------------

  IconData get _placeIcon {
    final String type = place.type.toLowerCase();

    if (type.contains('hotel') || type.contains('resort')) {
      return Icons.hotel_outlined;
    }

    if (type.contains('restaurant') ||
        type.contains('cafe') ||
        type.contains('food')) {
      return Icons.restaurant_outlined;
    }

    if (type.contains('parking')) {
      return Icons.local_parking_outlined;
    }

    if (type.contains('hospital') ||
        type.contains('medical') ||
        type.contains('health')) {
      return Icons.local_hospital_outlined;
    }

    return Icons.place_outlined;
  }

  // ---------------------------------------------------------

  // DEFAULT DESCRIPTION

  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // =====================================================

                    // TOP BAR

                    // =====================================================
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.arrow_back,

                            color: primaryGreen,
                          ),
                        ),

                        Expanded(
                          child: Text(
                            place.name,

                            textAlign: TextAlign.center,

                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,

                              fontWeight: FontWeight.w700,

                              color: primaryGreen,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite
                                      ? '${place.name} added to favorites'
                                      : '${place.name} removed from favorites',
                                ),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xFF303533),
                              ),
                            );
                          },

                          icon: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,

                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // =====================================================

                    // MAIN IMAGE

                    // =====================================================
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),

                      child: SizedBox(
                        width: double.infinity,

                        height: 220,

                        child: place.imagePath.isNotEmpty
                            ? Image.asset(
                                place.imagePath,

                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return _buildImagePlaceholder();
                                },
                              )
                            : _buildImagePlaceholder(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // =====================================================

                    // PLACE NAME

                    // =====================================================
                    Text(
                      place.name,

                      style: GoogleFonts.playfairDisplay(
                        fontSize: 23,

                        fontWeight: FontWeight.w700,

                        color: primaryGreen,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =====================================================

                    // TYPE + LOCATION

                    // =====================================================
                    Row(
                      children: [
                        Text(
                          place.type,

                          style: GoogleFonts.inter(
                            fontSize: 11,

                            color: accentColor,

                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Container(
                          width: 4,

                          height: 4,

                          decoration: const BoxDecoration(
                            color: primaryGreen,

                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 10),

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
                              fontSize: 11,

                              color: primaryGreen.withValues(alpha: 0.70),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // =====================================================

                    // INFORMATION CARD

                    // =====================================================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,

                        vertical: 14,
                      ),

                      decoration: BoxDecoration(
                        color: cardColor,

                        borderRadius: BorderRadius.circular(15),

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
                          // RATING

                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,

                                  color: accentColor,

                                  size: 21,
                                ),

                                const SizedBox(width: 6),

                                Text(
                                  place.rating != null
                                      ? place.rating!.toStringAsFixed(1)
                                      : 'Not rated',

                                  style: GoogleFonts.inter(
                                    fontSize: 13,

                                    fontWeight: FontWeight.w600,

                                    color: primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 1.2,

                            height: 32,

                            margin: const EdgeInsets.symmetric(horizontal: 12),

                            color: primaryGreen.withValues(alpha: 0.35),
                          ),

                          // LOCATION
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),

                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,

                                    size: 18,

                                    color: primaryGreen,
                                  ),

                                  const SizedBox(width: 6),

                                  Expanded(
                                    child: Text(
                                      place.location,

                                      maxLines: 1,

                                      overflow: TextOverflow.ellipsis,

                                      style: GoogleFonts.inter(
                                        fontSize: 10,

                                        color: primaryGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =====================================================

                    // ABOUT

                    // =====================================================
                    Text(
                      'About this Location',

                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,

                        fontWeight: FontWeight.w700,

                        color: primaryGreen,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      place.description.isNotEmpty
                          ? place.description
                          : 'Information about this location will be available soon.',

                      style: GoogleFonts.inter(
                        fontSize: 13,

                        height: 1.5,

                        color: primaryGreen.withValues(alpha: 0.78),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =====================================================

                    // BUTTONS

                    // =====================================================
                    Row(
                      children: [
                        Expanded(
                          flex: 2,

                          child: SizedBox(
                            height: 47,

                            child: ElevatedButton.icon(
                              onPressed: () {
                                _openMap(context);
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,

                                foregroundColor: backgroundColor,

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),

                              icon: const Icon(Icons.map_outlined, size: 19),

                              label: Text(
                                'View on Map',

                                style: GoogleFonts.inter(
                                  fontSize: 13,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: SizedBox(
                            height: 47,

                            child: OutlinedButton.icon(
                              onPressed: () async {
                                try {
                                  if (isSaved) {
                                    await _savedPlacesService.removeSavedPlace(
                                      place.name,
                                    );
                                  } else {
                                    await _savedPlacesService.savePlace(
                                      place.name,
                                    );
                                  }

                                  if (!context.mounted) return;

                                  setState(() {
                                    isSaved = !isSaved;
                                  });

                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isSaved
                                            ? '${place.name} saved successfully'
                                            : '${place.name} removed from saved',
                                      ),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xFF303533),
                                    ),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Unable to save place: $e'),
                                      duration: const Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xFF303533),
                                    ),
                                  );
                                }
                              },

                              style: OutlinedButton.styleFrom(
                                backgroundColor: isSaved
                                    ? primaryGreen
                                    : Colors.transparent,

                                foregroundColor: isSaved
                                    ? backgroundColor
                                    : primaryGreen,

                                side: BorderSide(
                                  color: primaryGreen.withValues(
                                    alpha: isSaved ? 1.0 : 0.30,
                                  ),
                                ),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),

                              icon: Icon(
                                isSaved
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_border_rounded,

                                size: 18,
                              ),

                              label: Text(
                                isSaved ? 'Saved' : 'Save',

                                style: GoogleFonts.inter(
                                  fontSize: 12,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // =====================================================

                    // GALLERY

                    // =====================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          'Gallery',

                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,

                            fontWeight: FontWeight.w700,

                            color: primaryGreen,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlaceGalleryScreen(place: place),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: primaryGreen,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'See All >',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // For now use the available place image.

                    // Later we can add 3 separate gallery images.
                    SizedBox(
                      height: 90,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildMockGalleryImage(
                              'assets/images/services/anuradhapura/Heritage Hotel Anuradhapura.jpg',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildMockGalleryImage(
                              'assets/images/services/anuradhapura/Hotel Alakamanda.jpg',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildMockGalleryImage(
                              'assets/images/services/anuradhapura/The Lake Forest Hotel.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================================================

            // BOTTOM NAVIGATION

            // =========================================================
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // =========================================================

  // IMAGE PLACEHOLDER

  // =========================================================

  Widget _buildImagePlaceholder() {
    return Container(
      color: cardColor,

      child: Center(child: Icon(_placeIcon, size: 50, color: accentColor)),
    );
  }

  // =========================================================

  // GALLERY IMAGE

  // =========================================================

  Widget _buildMockGalleryImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder();
        },
      ),
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION

  // =========================================================

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
            _navItem(icon: Icons.home_outlined, label: 'Home'),

            _navItem(
              icon: Icons.grid_view_rounded,

              label: 'Services',

              selected: true,
            ),

            _navItem(icon: Icons.bookmark_border_rounded, label: 'Saved'),

            _navItem(icon: Icons.person_outline_rounded, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,

    required String label,

    bool selected = false,
  }) {
    return Container(
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
    );
  }
}
