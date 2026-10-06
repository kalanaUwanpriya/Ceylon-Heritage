import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
          'Terms of Service',
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
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: Icon(
                          Icons.description_outlined,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                    ),
                    SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Using Ceylon Heritage',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'These Terms of Service explain the basic rules and responsibilities for using the Ceylon Heritage application.',
                            style: TextStyle(
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

              const Text(
                'Last Updated',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              const Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: accentColor,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'October 2026',
                    style: TextStyle(color: secondaryTextColor, fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              _buildTermsSection(
                number: '1',
                title: 'Acceptance of Terms',
                content:
                    'By creating an account or using Ceylon Heritage, you agree to follow these Terms of Service while using the application and its available features.',
              ),

              _buildTermsSection(
                number: '2',
                title: 'User Accounts',
                content:
                    'Some features require an account. You are responsible for providing appropriate account information and keeping your login credentials secure.',
              ),

              _buildTermsSection(
                number: '3',
                title: 'Use of Ceylon Heritage',
                content:
                    'Ceylon Heritage is designed to help users explore Sri Lankan heritage destinations, historical places, walking routes and related travel information. You should use the application responsibly and only for lawful purposes.',
              ),

              _buildTermsSection(
                number: '4',
                title: 'Heritage and Travel Information',
                content:
                    'Information about destinations, historical places, routes, opening hours, fees and other travel details may change over time. Users should verify important travel information with appropriate official or local sources before making travel decisions.',
              ),

              _buildTermsSection(
                number: '5',
                title: 'Saved Places and Routes',
                content:
                    'The application may allow you to save places or routes to your account. Availability of saved information depends on the application features and services currently provided.',
              ),

              _buildTermsSection(
                number: '6',
                title: 'Reviews and Ratings',
                content:
                    'If review or rating features are available, users should submit genuine and appropriate feedback. Content that misuses the service may be restricted or removed when necessary.',
              ),

              _buildTermsSection(
                number: '7',
                title: 'Location Information',
                content:
                    'Some application features may use location information to support navigation or location-based experiences. Location features depend on device permissions and available services.',
              ),

              _buildTermsSection(
                number: '8',
                title: 'Third-Party Services',
                content:
                    'Ceylon Heritage may use third-party services such as Firebase, maps or other supporting technologies. Those services may operate under their own terms and policies.',
              ),

              _buildTermsSection(
                number: '9',
                title: 'Account Responsibilities',
                content:
                    'You are responsible for activity performed through your account and should not intentionally misuse the application, interfere with its operation or attempt unauthorized access to other users or application data.',
              ),

              _buildTermsSection(
                number: '10',
                title: 'Limitation of Information',
                content:
                    'Ceylon Heritage provides heritage and travel information for informational purposes. While the application aims to provide useful information, accuracy, completeness and availability cannot always be guaranteed.',
              ),

              _buildTermsSection(
                number: '11',
                title: 'Changes to These Terms',
                content:
                    'These Terms of Service may be updated when application features or requirements change. The latest version will be made available within the application.',
              ),

              _buildTermsSection(
                number: '12',
                title: 'Contact Us',
                content:
                    'If you have questions about these Terms of Service or the Ceylon Heritage application, please use the Help & Support section of the application.',
              ),

              const SizedBox(height: 10),

              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_rounded,
                      color: accentColor,
                      size: 28,
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Ceylon Heritage',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Discover Sri Lanka',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '© 2026 Ceylon Heritage',
                      style: TextStyle(color: secondaryTextColor, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTermsSection({
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
              style: const TextStyle(
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
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
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
