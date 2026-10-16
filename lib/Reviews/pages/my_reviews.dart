import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/review.dart';
import '../services/review_service.dart';
import '../widgets/review_card.dart';
import '../widgets/review_modal.dart';
import '../widgets/delete_review_dialog.dart';
import '../../widgets/app_navigation_bar.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  final ReviewService _reviewService = ReviewService();

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color secondaryText = Color(0xFF5F625D);

  void _openEditModal(Review review) {
    ReviewModal.show(
      context,
      placeId: review.placeId,
      placeName: review.placeName,
      placeImage: review.placeImage,
      location: review.location,
      initialRating: review.rating,
      existingReviewId: review.id,
      onReviewSaved: () {
        // UI updates automatically via StreamBuilder
      },
      onReviewDeleted: () {
        // UI updates automatically via StreamBuilder
      },
    );
  }

  void _confirmDelete(Review review) {
    DeleteReviewDialog.show(
      context,
      onConfirmDelete: () async {
        try {
          await _reviewService.deleteReview(review.id);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Review deleted successfully',
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to delete review: $e',
                style: GoogleFonts.inter(),
              ),
              backgroundColor: Colors.red[800],
            ),
          );
        }
      },
    );
  }

  void _handleInlineSave(Review review, int newRating) async {
    try {
      await _reviewService.updateReview(review.id, newRating);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Review updated successfully',
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update review: $e'),
          backgroundColor: Colors.red[800],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryGreen,
            size: 26,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Reviews',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: primaryGreen,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: user == null
            ? _buildNotLoggedInState()
            : StreamBuilder<List<Review>>(
                stream: _reviewService.getCurrentUserReviews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryGreen,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'Error loading reviews: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    );
                  }

                  final reviews = snapshot.data ?? [];

                  if (reviews.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    itemCount: reviews.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ReviewCard(
                        review: review,
                        onEdit: () => _openEditModal(review),
                        onDelete: () => _confirmDelete(review),
                        onSaveInline: (newRating) =>
                            _handleInlineSave(review, newRating),
                      );
                    },
                  );
                },
              ),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: 3, // Profile tab active
        onDestinationSelected: (index) {
          AppNavigationBar.handleNavigation(context, index, currentIndex: 3);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_outline_rounded,
              size: 64,
              color: Color(0xFFC8B9A5),
            ),
            const SizedBox(height: 16),
            Text(
              'No Reviews Yet',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rate historical places across Sri Lanka using our 3-star rating system and your reviews will appear here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: secondaryText,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotLoggedInState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 64,
              color: Color(0xFFC8B9A5),
            ),
            const SizedBox(height: 16),
            Text(
              'Sign In Required',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please log in to your account to view and manage your reviews.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: secondaryText,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
