import 'package:flutter/material.dart';

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
                  top: h * 0.67,
                  left: 22,
                  right: 20,
                  child: const Text(
                    'Navigate Easily',
                    style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF294D1C),
                      height: 1.05,
                    ),
                  ),
                ),

                // ================= DESCRIPTION =================
                Positioned(
                  top: h * 0.73,
                  left: 22,
                  right: 20,
                  child: const Text(
                    'Use GPS Navigation and\n'
                    'offline information while\n'
                    'exploring.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'serif',
                      color: Color(0xFF111111),
                      height: 1.25,
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
                        // Passe Login/Home ekata connect karamu
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF536B35),
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
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'serif',
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
        color: active ? const Color(0xFF4B5427) : Colors.white,
      ),
    );
  }
}
