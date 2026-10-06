import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/app_navigation_bar.dart';
import '../profile_screen.dart';

class WalkingPlanPage extends StatefulWidget {
  const WalkingPlanPage({super.key});

  @override
  State<WalkingPlanPage> createState() => _WalkingPlanPageState();
}

class _WalkingPlanPageState extends State<WalkingPlanPage> {
  // ============================================================
  // DESIGN SYSTEM CONSTANTS
  // ============================================================
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color secondaryTextColor = Color(0xFF5F625D);

  // Selected dropdown values
  String _selectedTempo = 'Moderate';
  String _selectedTime = '1 Day';
  String _selectedRating = '3 Star';

  // Option lists
  final List<String> _tempoOptions = const [
    'Leisurely',
    'Moderate',
    'Quick',
  ];

  final List<String> _timeOptions = const [
    '8h',
    '12h',
    '1 Day',
    '2 Day',
  ];

  final List<String> _ratingOptions = const [
    '1 Star',
    '2 Star',
    '3 Star',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Top Navigation Bar
                      _buildTopBar(context),

                      // Heading with subtle sketch background
                      _buildHeadingSection(),

                      const SizedBox(height: 18),

                      // Cards Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            // Card 1: Tempo
                            _buildPreferenceCard(
                              icon: Icons.speed_outlined,
                              title: 'Choose your tempo',
                              subtitle: 'How do you prefer to explore?',
                              selectedValue: _selectedTempo,
                              options: _tempoOptions,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedTempo = value);
                                }
                              },
                            ),

                            const SizedBox(height: 14),

                            // Card 2: Time available
                            _buildPreferenceCard(
                              icon: Icons.hourglass_empty_rounded,
                              title: 'Time available',
                              subtitle: 'How long do you have?',
                              selectedValue: _selectedTime,
                              options: _timeOptions,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedTime = value);
                                }
                              },
                            ),

                            const SizedBox(height: 14),

                            // Card 3: Minimum Rating
                            _buildPreferenceCard(
                              icon: Icons.star_outline_rounded,
                              title: 'Minimum Rating',
                              subtitle: 'What is the minimum rating you prefer?',
                              selectedValue: _selectedRating,
                              options: _ratingOptions,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedRating = value);
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      // Flexible spacer to push button down on tall screens
                      const Spacer(),

                      const SizedBox(height: 20),

                      // Bottom Action Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Starting Walking Tour: $_selectedTempo • $_selectedTime • $_selectedRating',
                                    style: GoogleFonts.inter(
                                      color: backgroundColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.directions_walk_rounded,
                              size: 24,
                            ),
                            label: Text(
                              'START',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: backgroundColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pop(context);
            return;
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                index == 1
                    ? 'Services will be connected next.'
                    : 'Saved will be connected next.',
                style: GoogleFonts.inter(),
              ),
              backgroundColor: primaryColor,
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: primaryColor,
              size: 24,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Text(
            'Plan Your Walk',
            style: GoogleFonts.playfairDisplay(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Empty spacer to ensure exact center alignment of the title
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ============================================================
  // HEADING SECTION WITH Abackg.png BACKGROUND
  // ============================================================
  Widget _buildHeadingSection() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background sketch illustration fading downwards
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 185,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.4, 0.95],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Opacity(
                opacity: 0.38,
                child: Image.asset(
                  'assets/images/Abackg.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Heading Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 52),
                Text(
                  'Plan Your Walk',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Create a personalized journey through time.\nTell us what moves you, and we\'ll map the\nfootsteps of history to your pace.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: primaryColor.withValues(alpha: 0.88),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 16),
                _buildOrnamentalDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORNAMENTAL DIVIDER WITH DIAMOND
  // ============================================================
  Widget _buildOrnamentalDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withValues(alpha: 0.0),
                accentColor.withValues(alpha: 0.55),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Transform.rotate(
            angle: 0.785398, // 45 degrees
            child: Container(
              width: 5.5,
              height: 5.5,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withValues(alpha: 0.55),
                accentColor.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PREFERENCE CARD COMPONENT
  // ============================================================
  Widget _buildPreferenceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String selectedValue,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF17452F).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with Icon
          Row(
            children: [
              Icon(
                icon,
                color: accentColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          // Subtitle
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 12),

          // Dropdown Field
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.25),
                width: 1.1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: primaryColor,
                  size: 22,
                ),
                dropdownColor: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
