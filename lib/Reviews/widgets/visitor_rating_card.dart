import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/review_service.dart';
import 'rating_stars.dart';
import 'review_modal.dart';

class VisitorRatingCard extends StatelessWidget {
  final String placeId;
  final String placeName;
  final String placeImage;
  final String location;
  final VoidCallback? onTap;

  const VisitorRatingCard({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.placeImage,
    required this.location,
    this.onTap,
  });

  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color accentBrown = Color(0xFF9F5625);
  static const Color borderColor = Color(0xFFE1D2BD);
  static const Color secondaryText = Color(0xFF5F625D);

  @override
  Widget build(BuildContext context) {
    final reviewService = ReviewService();

    return StreamBuilder<PlaceReviewStats>(
      stream: reviewService.getPlaceReviewStats(placeId),
      builder: (context, snapshot) {
        final stats =
            snapshot.data ?? const PlaceReviewStats(count: 0, average: 0.0);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ??
                () {
                  ReviewModal.show(
                    context,
                    placeId: placeId,
                    placeName: placeName,
                    placeImage: placeImage,
                    location: location,
                  );
                },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visitor Rating',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      // LIVE 3-STAR DISPLAY (Max 3 stars)
                      RatingStars(
                        rating: stats.average,
                        size: 26,
                        spacing: 3,
                        selectedColor: accentBrown,
                        unselectedColor: accentBrown.withValues(alpha: 0.45),
                      ),
                      const SizedBox(width: 10),
                      // Stats text matching Screenshot 2: "2.4 / 3  |  (1,256 reviews)"
                      Expanded(
                        child: Text(
                          '${stats.formattedAverage} / 3  |  (${stats.formattedCount})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Right chevron icon matching Screenshot 2
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: primaryGreen,
                        size: 26,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
