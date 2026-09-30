import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const Color primaryGreen = Color(0xFF1E3A2B);
  static const Color backgroundColor = Color(0xFFF7F2EB);
  static const Color goldColor = Color(0xFFC88E38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ============================================================
      // APP BAR
      // ============================================================
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryGreen),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'About App',
          style: TextStyle(
            color: primaryGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ======================================================
              // APP ICON
              // ======================================================
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.account_balance,
                  size: 52,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(height: 18),

              // ======================================================
              // APP NAME
              // ======================================================
              const Text(
                'Heritage Walks',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Discover Sri Lanka',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),

              const SizedBox(height: 28),

              // ======================================================
              // ABOUT THE APP
              // ======================================================
              _buildSectionCard(
                title: 'About Heritage Walks',
                icon: Icons.explore_outlined,
                child: const Text(
                  'Heritage Walks is a mobile application designed to help users discover and explore the historical and cultural heritage of Sri Lanka.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ======================================================
              // WHAT YOU CAN DO
              // ======================================================
              _buildSectionCard(
                title: 'What You Can Do',
                icon: Icons.travel_explore_outlined,
                child: Column(
                  children: [
                    _buildFeatureRow(
                      Icons.location_city_outlined,
                      'Explore historical destinations',
                    ),
                    _buildFeatureRow(
                      Icons.account_balance_outlined,
                      'Discover important heritage places',
                    ),
                    _buildFeatureRow(
                      Icons.directions_walk_outlined,
                      'Plan walking routes',
                    ),
                    _buildFeatureRow(
                      Icons.bookmark_outline,
                      'Save places and routes',
                    ),
                    _buildFeatureRow(
                      Icons.star_outline,
                      'Rate and review places',
                    ),
                    _buildFeatureRow(
                      Icons.headphones_outlined,
                      'Listen to audio guides',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ======================================================
              // OUR PURPOSE
              // ======================================================
              _buildSectionCard(
                title: 'Our Purpose',
                icon: Icons.favorite_border,
                child: const Text(
                  'Our goal is to make exploring Sri Lanka’s heritage easier, more informative and more enjoyable by bringing useful historical information, walking routes and travel features together in one application.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ======================================================
              // DEVELOPED FOR
              // ======================================================
              _buildSectionCard(
                title: 'Developed For',
                icon: Icons.school_outlined,
                child: const Text(
                  'Heritage Walks – Discover Sri Lanka is developed as a university group project with the aim of creating a digital platform for discovering Sri Lankan heritage.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ======================================================
              // FOOTER
              // ======================================================
              const Text(
                'Made with care for Sri Lankan heritage',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                '© 2026 Heritage Walks',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // SECTION CARD
  // ================================================================

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: primaryGreen, size: 22),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: primaryGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          child,
        ],
      ),
    );
  }

  // ================================================================
  // FEATURE ROW
  // ================================================================

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: goldColor, size: 20),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
