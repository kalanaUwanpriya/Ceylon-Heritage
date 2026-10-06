import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen_3.dart';
import '../login_screen.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E7D4),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;

            return Stack(
              children: [
                // ================= BACKGROUND IMAGE =================
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: h * 0.67, // 0.57 -> 0.62
                  child: Image.asset(
                    'assets/images/onboarding2.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),

                // ================= TITLE =================
                Positioned(
                  top: h * 0.65,
                  left: 22,
                  right: 20,
                  child: Text(
                    'Plan Your Journey',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF17452F),
                      height: 1.10,
                    ),
                  ),
                ),

                // ================= DESCRIPTION =================
                Positioned(
                  top: h * 0.74,
                  left: 22,
                  right: 20,
                  child: Text(
                    'Choose the best walking route\n'
                    'based on your time and\n'
                    'interests.',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF17452F),
                      height: 1.35,
                    ),
                  ),
                ),

                // ================= DOTS =================
                Positioned(
                  top: h * 0.85,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(false),
                      const SizedBox(width: 12),
                      _dot(true),
                      const SizedBox(width: 12),
                      _dot(false),
                    ],
                  ),
                ),

                // ================= BOTTOM =================
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SKIP
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

                      // NEXT
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OnboardingScreen3(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF17452F),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 11,
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
            );
          },
        ),
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
