import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/review_service.dart';
import '../models/review.dart';
import 'rating_stars.dart';
import 'delete_review_dialog.dart';

class ReviewModal extends StatefulWidget {
  final String placeId;
  final String placeName;
  final String placeImage;
  final String location;
  final int? initialRating;
  final String? existingReviewId;
  final VoidCallback? onReviewSaved;
  final VoidCallback? onReviewDeleted;

  const ReviewModal({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.placeImage,
    required this.location,
    this.initialRating,
    this.existingReviewId,
    this.onReviewSaved,
    this.onReviewDeleted,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String placeId,
    required String placeName,
    required String placeImage,
    required String location,
    int? initialRating,
    String? existingReviewId,
    VoidCallback? onReviewSaved,
    VoidCallback? onReviewDeleted,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (context) => ReviewModal(
        placeId: placeId,
        placeName: placeName,
        placeImage: placeImage,
        location: location,
        initialRating: initialRating,
        existingReviewId: existingReviewId,
        onReviewSaved: onReviewSaved,
        onReviewDeleted: onReviewDeleted,
      ),
    );
  }

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  final ReviewService _reviewService = ReviewService();
  int _selectedRating = 0;
  bool _isSubmitting = false;
  bool _isLoadingInitial = true;
  Review? _existingReview;

  static const Color modalBackgroundColor = Color(0xFFF0DDC3);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color accentBrown = Color(0xFF9F5625);
  static const Color subtitleColor = Color(0xFF5F625D);
  static const Color handleBarColor = Color(0xFFC8B9A5);
  static const Color dividerColor = Color(0xFFE2D1BD);

  @override
  void initState() {
    super.initState();
    if (widget.initialRating != null && widget.initialRating! > 0) {
      _selectedRating = widget.initialRating!.clamp(1, 3);
      _isLoadingInitial = false;
    } else {
      _fetchExistingReview();
    }
  }

  Future<void> _fetchExistingReview() async {
    try {
      final existing =
          await _reviewService.getUserReviewForPlace(widget.placeId);
      if (mounted) {
        setState(() {
          _existingReview = existing;
          if (existing != null) {
            _selectedRating = existing.rating.clamp(1, 3);
          }
          _isLoadingInitial = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingInitial = false;
        });
      }
    }
  }

  Future<void> _submitReview() async {
    if (_selectedRating < 1 || _selectedRating > 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select 1, 2, or 3 stars.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: accentBrown,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please log in to submit a review.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: accentBrown,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _reviewService.createReview(
        placeId: widget.placeId,
        placeName: widget.placeName,
        placeImage: widget.placeImage,
        location: widget.location,
        rating: _selectedRating,
      );

      if (!mounted) return;

      Navigator.of(context).pop(true);

      widget.onReviewSaved?.call();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Review submitted successfully',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: primaryGreen,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to save review: $e',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.red[800],
        ),
      );
    }
  }

  Future<void> _handleDelete() async {
    final reviewId =
        widget.existingReviewId ?? _existingReview?.id;
    if (reviewId == null || reviewId.isEmpty) return;

    DeleteReviewDialog.show(
      context,
      onConfirmDelete: () async {
        try {
          await _reviewService.deleteReview(reviewId);
          if (!mounted) return;
          Navigator.of(context).pop(true);
          widget.onReviewDeleted?.call();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Review deleted successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: primaryGreen,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete review: $e'),
              backgroundColor: Colors.red[800],
            ),
          );
        }
      },
    );
  }

  Widget _buildPlaceThumbnail() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dividerColor,
      ),
      child: ClipOval(
        child: Image.asset(
          widget.placeImage,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.place,
              color: primaryGreen,
              size: 26,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: modalBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top drag handle
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: handleBarColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Header: Place image, Title, Subtitle, Close Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPlaceThumbnail(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.placeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Share your experience',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: subtitleColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_existingReview != null || widget.existingReviewId != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: accentBrown,
                        size: 24,
                      ),
                      tooltip: 'Delete review',
                      onPressed: _isSubmitting ? null : _handleDelete,
                    ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: subtitleColor,
                      size: 24,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(color: dividerColor, height: 1, thickness: 1),
              const SizedBox(height: 24),

              // Prompt text
              Text(
                'How was your experience?',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 18),

              // 3-Star Rating (interactive)
              if (_isLoadingInitial)
                const SizedBox(
                  height: 46,
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryGreen,
                      ),
                    ),
                  ),
                )
              else
                RatingStars(
                  rating: _selectedRating,
                  size: 46,
                  spacing: 12,
                  selectedColor: accentBrown,
                  unselectedColor: handleBarColor,
                  isInteractive: true,
                  onRatingChanged: (newRating) {
                    setState(() {
                      _selectedRating = newRating;
                    });
                  },
                ),

              const SizedBox(height: 28),

              // Green Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Submit',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
