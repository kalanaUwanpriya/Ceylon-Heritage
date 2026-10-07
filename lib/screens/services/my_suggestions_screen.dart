import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_suggestion_screen.dart';

class MySuggestionsScreen extends StatelessWidget {
  const MySuggestionsScreen({super.key});

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryGreen,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Suggestions',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: primaryGreen,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/services/my_suggestion.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: user == null
            ? Center(
                child: Text(
                  'Please login first.',
                  style: GoogleFonts.inter(color: primaryGreen, fontSize: 14),
                ),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('service_suggestions')
                    .where('userId', isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Unable to load suggestions.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: accentColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: primaryGreen),
                    );
                  }

                  final suggestions = snapshot.data?.docs ?? [];

                  if (suggestions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 55,
                            color: primaryGreen.withValues(alpha: 0.45),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'No suggestions yet',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: primaryGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Your submitted services will appear here.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryGreen.withValues(alpha: 0.65),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 30),
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final document = suggestions[index];

                      final data = document.data() as Map<String, dynamic>;

                      final String serviceName =
                          data['serviceName'] ?? 'Service';

                      final String city = data['city'] ?? '';

                      final String category = data['category'] ?? '';

                      final String location = data['location'] ?? '';

                      final String status = data['status'] ?? 'pending';

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardColor.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: primaryGreen.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: primaryGreen,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.storefront_outlined,
                                    color: backgroundColor,
                                    size: 21,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        serviceName,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: primaryGreen,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '$category • $city',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: primaryGreen.withValues(
                                            alpha: 0.70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                _buildStatusBadge(status),
                              ],
                            ),

                            if (location.isNotEmpty) ...[
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: primaryGreen.withValues(alpha: 0.70),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      location,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: primaryGreen.withValues(
                                          alpha: 0.75,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditSuggestionScreen(
                                                documentId: document.id,
                                                suggestion: data,
                                              ),
                                        ),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: primaryGreen,
                                      side: BorderSide(
                                        color: primaryGreen.withValues(
                                          alpha: 0.35,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 17,
                                    ),
                                    label: Text(
                                      'Edit',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      final bool?
                                      confirmDelete = await showDialog<bool>(
                                        context: context,
                                        builder: (dialogContext) {
                                          return AlertDialog(
                                            backgroundColor: backgroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            title: Text(
                                              'Delete Suggestion?',
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: primaryGreen,
                                                  ),
                                            ),
                                            content: Text(
                                              'Are you sure you want to delete "$serviceName"?',
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: primaryGreen,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                    dialogContext,
                                                    false,
                                                  );
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.inter(
                                                    color: primaryGreen,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                    dialogContext,
                                                    true,
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: accentColor,
                                                  foregroundColor: Colors.white,
                                                  elevation: 0,
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirmDelete != true) return;

                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('service_suggestions')
                                            .doc(document.id)
                                            .delete();

                                        if (!context.mounted) return;

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Suggestion deleted successfully!',
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        if (!context.mounted) return;

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to delete suggestion: $e',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: accentColor,
                                      side: BorderSide(
                                        color: accentColor.withValues(
                                          alpha: 0.40,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 17,
                                    ),
                                    label: Text(
                                      'Delete',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final String text = status.isEmpty
        ? 'Pending'
        : '${status[0].toUpperCase()}${status.substring(1)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: accentColor,
        ),
      ),
    );
  }
}
