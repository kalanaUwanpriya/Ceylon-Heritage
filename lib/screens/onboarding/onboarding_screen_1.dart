import 'package:flutter/material.dart';
import 'onboarding_screen_2.dart';

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
                        child: const Text(
                          "Explore Sri Lanka's\nHeritage",
                          style: TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF294D1C),
                            height: 1.05,
                          ),
                        ),
                      ),

                      // ---------- DESCRIPTION ----------
                      Positioned(
                        top: h * 0.71,
                        left: 0,
                        right: 0,
                        child: const Text(
                          'Discover ancient temples, fortresses,\n'
                          'and cultural landmarks through guided\n'
                          'walking tours.',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'serif',
                            color: Color(0xFF111111),
                            height: 1.25,
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
                                // Skip navigation connect later
                              },
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF294D1C),
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
                                backgroundColor: const Color(0xFF4C6B32),
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
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 15,
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
        color: active ? const Color(0xFF4B5427) : Colors.white,
      ),
    );
  }
}
