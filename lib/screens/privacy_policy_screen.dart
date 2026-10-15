import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_navigation_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.playfairDisplay(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: Icon(
                          Icons.privacy_tip_outlined,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Privacy Matters',
                            style: GoogleFonts.inter(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'This Privacy Policy explains how Heritage Walks handles information when you use the application.',
                            style: GoogleFonts.inter(
                              color: secondaryTextColor,
                              fontSize: 13,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Last Updated',
                style: GoogleFonts.inter(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: accentColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'September 2026',
                    style: GoogleFonts.inter(
                      color: secondaryTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              _buildPolicySection(
                number: '1',
                title: 'Information We Collect',
                content:
                    'When you use Ceylon Heritage, the application may store information needed to provide its features. This can include your name, email address, phone number, profile information and information related to your use of the application.',
              ),
              _buildPolicySection(
                number: '2',
                title: 'How We Use Information',
                content:
                    'Information may be used to provide account features, personalize your experience, manage saved places and routes, maintain visited history, support reviews and ratings, and provide notifications and other application features.',
              ),
              _buildPolicySection(
                number: '3',
                title: 'Account Information',
                content:
                    'Your account information is used to identify your account and provide access to features that require authentication. You can update available profile information through the Edit Profile section.',
              ),
              _buildPolicySection(
                number: '4',
                title: 'Saved Places and Routes',
                content:
                    'When you save places or walking routes, information related to those saved items may be associated with your account so that you can access them later.',
              ),
              _buildPolicySection(
                number: '5',
                title: 'Visited History',
                content:
                    'If the visited-history feature is used, information about places you mark as visited may be stored with your account so that you can view your visited places later.',
              ),
              _buildPolicySection(
                number: '6',
                title: 'Reviews and Ratings',
                content:
                    'Ratings and reviews submitted through the application may be stored and associated with your account and the relevant historical place. This information may be used to provide the review and rating features.',
              ),
              _buildPolicySection(
                number: '7',
                title: 'Notifications',
                content:
                    'The application may store your notification preferences so that notification categories can be managed according to your selected settings.',
              ),
              _buildPolicySection(
                number: '8',
                title: 'Data Security',
                content:
                    'Ceylon Heritage uses Firebase services for authentication and cloud data storage. Access to application data is controlled using authentication and database security rules.',
              ),
              _buildPolicySection(
                number: '9',
                title: 'Third-Party Services',
                content:
                    'The application may use third-party services such as Firebase and map or other supporting services to provide application functionality. These services may process information according to their own privacy policies.',
              ),
              _buildPolicySection(
                number: '10',
                title: 'Your Choices',
                content:
                    'You can manage available profile information and notification preferences through the application. You can also log out of your account at any time.',
              ),
              _buildPolicySection(
                number: '11',
                title: 'Changes to This Policy',
                content:
                    'This Privacy Policy may be updated when application features or requirements change. The latest version will be made available within the application.',
              ),
              _buildPolicySection(
                number: '12',
                title: 'Contact Us',
                content:
                    'If you have questions about this Privacy Policy or the Heritage Walks application, please use the Help & Support section of the application.',
              ),

              const SizedBox(height: 16),

              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ALogo.png',
                      width: 140,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '© 2026 Ceylon Heritage',
                      style: GoogleFonts.inter(
                        color: secondaryTextColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
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

  static Widget _buildPolicySection({
    required String number,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accentColor.withValues(alpha: 0.20)),
            ),
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: accentColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: GoogleFonts.inter(
                    color: secondaryTextColor,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
