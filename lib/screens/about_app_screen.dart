import 'package:flutter/material.dart';

import '../widgets/app_navigation_bar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: cardColor,
              foregroundColor: primaryColor,
            ),
            icon: const Icon(Icons.arrow_back_rounded, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'About App',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ALogo.png',
                width: 170,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              const Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionCard(
                title: 'About Ceylon Heritage',
                icon: Icons.explore_outlined,
                child: const Text(
                  'Ceylon Heritage is a mobile application designed to help users discover and explore the historical and cultural heritage of Sri Lanka.',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
              ),

              const SizedBox(height: 12),

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
                      Icons.favorite_border_rounded,
                      'Save places and routes',
                    ),
                    _buildFeatureRow(
                      Icons.star_outline_rounded,
                      'Rate and review places',
                    ),
                    _buildFeatureRow(
                      Icons.headphones_outlined,
                      'Listen to audio guides',
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              _buildSectionCard(
                title: 'Our Purpose',
                icon: Icons.favorite_border_rounded,
                child: const Text(
                  'Our goal is to make exploring Sri Lanka’s heritage easier, more informative and more enjoyable by bringing useful historical information, walking routes and travel features together in one application.',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _buildSectionCard(
                title: 'Developed For',
                icon: Icons.school_outlined,
                child: const Text(
                  'Ceylon Heritage – Discover Sri Lanka is developed as a university group project with the aim of creating a digital platform for discovering Sri Lankan heritage.',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_rounded, color: accentColor, size: 16),
                  SizedBox(width: 7),
                  Flexible(
                    child: Text(
                      'Made with care for Sri Lankan heritage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '© 2026 Ceylon Heritage',
                textAlign: TextAlign.center,
                style: TextStyle(color: secondaryTextColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: 3,
        onDestinationSelected: (index) {
          AppNavigationBar.handleNavigation(context, index, currentIndex: 3);
        },
      ),
    );
  }

  static Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Center(child: Icon(icon, color: primaryColor, size: 23)),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  static Widget _buildFeatureRow(
    IconData icon,
    String text, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 11),
      child: Row(
        children: [
          Icon(icon, color: accentColor, size: 20),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: secondaryTextColor,
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
