import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/review.dart';
import 'rating_stars.dart';

class ReviewCard extends StatefulWidget {
  final Review review;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<int>? onSaveInline;

  const ReviewCard({
    super.key,
    required this.review,
    required this.onEdit,
    required this.onDelete,
    this.onSaveInline,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _isInlineEditing = false;
  late int _editingRating;

  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color accentBrown = Color(0xFF9F5625);
  static const Color secondaryText = Color(0xFF5F625D);
  static const Color borderColor = Color(0xFFE2D1BD);
  static const Color editCircleBg = Color(0xFFE7D3BA);

  @override
  void initState() {
    super.initState();
    _editingRating = widget.review.rating;
  }

  @override
  void didUpdateWidget(covariant ReviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.review.rating != widget.review.rating) {
      _editingRating = widget.review.rating;
    }
  }

  void _handleSave() {
    setState(() {
      _isInlineEditing = false;
    });
    if (widget.onSaveInline != null) {
      widget.onSaveInline!(_editingRating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Place image
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 76,
              height: 76,
              child: Image.asset(
                widget.review.placeImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFDECBB2),
                    child: const Icon(
                      Icons.image_outlined,
                      color: primaryGreen,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Place details & 3-star rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.review.placeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: primaryGreen,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: accentBrown,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        widget.review.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12.5,
                          color: secondaryText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                RatingStars(
                  rating: _isInlineEditing
                      ? _editingRating
                      : widget.review.rating,
                  size: 24,
                  spacing: 4,
                  selectedColor: accentBrown,
                  unselectedColor: const Color(0xFFC8B9A5),
                  isInteractive: _isInlineEditing,
                  onRatingChanged: (newRating) {
                    setState(() {
                      _editingRating = newRating;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right action controls
          if (_isInlineEditing)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Outlined SAVE button
                OutlinedButton(
                  onPressed: _handleSave,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: accentBrown,
                    side: const BorderSide(color: accentBrown, width: 1.4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: accentBrown,
                    ),
                  ),
                ),
                Container(
                  height: 24,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: const Color(0xFFC8B9A5),
                ),
                // Trash delete button
                IconButton(
                  onPressed: widget.onDelete,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: accentBrown,
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Delete review',
                ),
              ],
            )
          else
            // Circular pencil button (Screenshot 3)
            InkWell(
              onTap: widget.onEdit,
              onLongPress: () {
                // Also allow toggling inline edit mode
                setState(() {
                  _isInlineEditing = true;
                });
              },
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: editCircleBg,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: primaryGreen,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
