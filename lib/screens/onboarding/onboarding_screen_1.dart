import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen_2.dart';
import '../login_screen.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E7D4),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding1.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final h = constraints.maxHeight;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Stack(
                    children: [
                      // ---------- TITLE ----------
                      Positioned(
                        top: h * 0.15,
                        left: 0,
                        right: 0,
                        child: Text(
                          "Explore Sri Lanka's\nHeritage",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF17452F),
                            height: 1.10,
                          ),
                        ),
                      ),

                      // ---------- DESCRIPTION ----------
                      Positioned(
                        top: h * 0.71,
                        left: 0,
                        right: 0,
                        child: Text(
                          'Discover ancient temples, fortresses,\n'
                          'and cultural landmarks through guided\n'
                          'walking tours.',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF17452F),
                            height: 1.35,
                          ),
                        ),
                      ),

                      // ---------- PAGE DOTS ----------
                      Positioned(
                        top: h * 0.83,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dot(true),
                            const SizedBox(width: 12),
                            _dot(false),
                            const SizedBox(width: 12),
                            _dot(false),
                          ],
                        ),
                      ),

                      // ---------- BOTTOM BUTTONS ----------
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Skip',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF17452F),
                                ),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OnboardingScreen2(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF17452F),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Next',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFF17452F) : const Color(0xFFE8C99F),
      ),
    );
  }
}
