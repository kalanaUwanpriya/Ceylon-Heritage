import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'service_data.dart';

class PlaceGalleryScreen extends StatelessWidget {
  final ServicePlace place;

  const PlaceGalleryScreen({super.key, required this.place});

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/images/services/anuradhapura/Heritage Hotel Anuradhapura.jpg',
      'assets/images/services/anuradhapura/Hotel Alakamanda.jpg',
      'assets/images/services/anuradhapura/The Lake Forest Hotel.jpg',
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: primaryGreen),
        ),
        title: Text(
          '${place.name} Gallery',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: primaryGreen,
          ),
        ),
      ),
      body: images.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'More photos are not available for this location yet.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: primaryGreen.withValues(alpha: 0.75),
                  ),
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    color: cardColor,
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: accentColor,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
