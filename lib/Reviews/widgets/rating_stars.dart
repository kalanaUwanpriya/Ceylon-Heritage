import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  /// The current rating, strictly clamped between 0 and 3.
  final num rating;

  /// Maximum allowed rating is ALWAYS 3.
  static const int maxRating = 3;

  /// Size of each star icon.
  final double size;

  /// Color of selected/active stars.
  final Color selectedColor;

  /// Color of unselected/inactive stars.
  final Color unselectedColor;

  /// Spacing between stars.
  final double spacing;

  /// Whether the stars can be clicked/tapped to select a rating.
  final bool isInteractive;

  /// Callback when a star is selected (values 1, 2, or 3).
  final ValueChanged<int>? onRatingChanged;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 24.0,
    this.selectedColor = const Color(0xFF9F5625),
    this.unselectedColor = const Color(0xFFC8B9A5),
    this.spacing = 4.0,
    this.isInteractive = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Round rating to the nearest integer for star icon representation (max 3)
    final clampedRating = rating.clamp(0, maxRating);
    final activeCount = clampedRating.round();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= activeCount;

        Widget starIcon = Icon(
          isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
          color: isFilled ? selectedColor : unselectedColor,
          size: size,
        );

        if (isInteractive) {
          starIcon = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (onRatingChanged != null) {
                onRatingChanged!(starValue);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: starIcon,
            ),
          );
        } else {
          starIcon = Padding(
            padding: EdgeInsets.only(right: index < maxRating - 1 ? spacing : 0),
            child: starIcon,
          );
        }

        return starIcon;
      }),
    );
  }
}
