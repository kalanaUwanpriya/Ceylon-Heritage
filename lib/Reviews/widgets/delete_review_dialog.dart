import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteReviewDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  const DeleteReviewDialog({
    super.key,
    required this.onConfirmDelete,
  });

  static Future<bool?> show(
    BuildContext context, {
    required VoidCallback onConfirmDelete,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => DeleteReviewDialog(
        onConfirmDelete: onConfirmDelete,
      ),
    );
  }

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: cardColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete this review?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to delete your review? This action cannot be undone.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: secondaryTextColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onConfirmDelete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
