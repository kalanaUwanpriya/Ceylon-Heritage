import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login_screen.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E7D4),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;

            return Stack(
              fit: StackFit.expand,
              children: [
                // ================= FULL BACKGROUND IMAGE =================
                // Image eka full screen ekema thiyenawa
                Image.asset('assets/images/onboarding3.png', fit: BoxFit.fill),

                // ================= TITLE =================
                // Road eka iwara wena cream area eke
                Positioned(
                  top: h * 0.65,
                  left: 22,
                  right: 20,
                  child: Text(
                    'Navigate Easily',
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
                  top: h * 0.73,
                  left: 22,
                  right: 20,
                  child: Text(
                    'Use GPS Navigation and\n'
                    'offline information while\n'
                    'exploring.',
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
                  top: h * 0.84,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(false),
                      const SizedBox(width: 12),
                      _dot(false),
                      const SizedBox(width: 12),
                      _dot(true),
                    ],
                  ),
                ),

                // ================= GET STARTED =================
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 32,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF17452F),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
