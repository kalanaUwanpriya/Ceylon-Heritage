import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======================================================
              // INTRODUCTION CARD
              // ======================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.privacy_tip_outlined,
                      color: primaryGreen,
                      size: 30,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Privacy Matters',
                            style: TextStyle(
                              color: primaryGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'This Privacy Policy explains how Heritage Walks handles information when you use the application.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ======================================================
              // LAST UPDATED
              // ======================================================
              const Text(
                'Last Updated',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'September 2026',
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),

              const SizedBox(height: 22),

              // ======================================================
              // SECTION 1
              // ======================================================
              _buildPolicySection(
                number: '1',
                title: 'Information We Collect',
                content:
                    'When you use Heritage Walks, the application may store information needed to provide its features. This can include your name, email address, phone number, profile information and information related to your use of the application.',
              ),

              // ======================================================
              // SECTION 2
              // ======================================================
              _buildPolicySection(
                number: '2',
                title: 'How We Use Information',
                content:
                    'Information may be used to provide account features, personalize your experience, manage saved places and routes, maintain visited history, support reviews and ratings, and provide notifications and other application features.',
              ),

              // ======================================================
              // SECTION 3
              // ======================================================
              _buildPolicySection(
                number: '3',
                title: 'Account Information',
                content:
                    'Your account information is used to identify your account and provide access to features that require authentication. You can update available profile information through the Edit Profile section.',
              ),

              // ======================================================
              // SECTION 4
              // ======================================================
              _buildPolicySection(
                number: '4',
                title: 'Saved Places and Routes',
                content:
                    'When you save places or walking routes, information related to those saved items may be associated with your account so that you can access them later.',
              ),

              // ======================================================
              // SECTION 5
              // ======================================================
              _buildPolicySection(
                number: '5',
                title: 'Visited History',
                content:
                    'If the visited-history feature is used, information about places you mark as visited may be stored with your account so that you can view your visited places later.',
              ),

              // ======================================================
              // SECTION 6
              // ======================================================
              _buildPolicySection(
                number: '6',
                title: 'Reviews and Ratings',
                content:
                    'Ratings and reviews submitted through the application may be stored and associated with your account and the relevant historical place. This information may be used to provide the review and rating features.',
              ),

              // ======================================================
              // SECTION 7
              // ======================================================
              _buildPolicySection(
                number: '7',
                title: 'Notifications',
                content:
                    'The application may store your notification preferences so that notification categories can be managed according to your selected settings.',
              ),

              // ======================================================
              // SECTION 8
              // ======================================================
              _buildPolicySection(
                number: '8',
                title: 'Data Security',
                content:
                    'Heritage Walks uses Firebase services for authentication and cloud data storage. Access to application data is controlled using authentication and database security rules.',
              ),

              // ======================================================
              // SECTION 9
              // ======================================================
              _buildPolicySection(
                number: '9',
                title: 'Third-Party Services',
                content:
                    'The application may use third-party services such as Firebase and map or other supporting services to provide application functionality. These services may process information according to their own privacy policies.',
              ),

              // ======================================================
              // SECTION 10
              // ======================================================
              _buildPolicySection(
                number: '10',
                title: 'Your Choices',
                content:
                    'You can manage available profile information and notification preferences through the application. You can also log out of your account at any time.',
              ),

              // ======================================================
              // SECTION 11
              // ======================================================
              _buildPolicySection(
                number: '11',
                title: 'Changes to This Policy',
                content:
                    'This Privacy Policy may be updated when application features or requirements change. The latest version will be made available within the application.',
              ),

              // ======================================================
              // SECTION 12
              // ======================================================
              _buildPolicySection(
                number: '12',
                title: 'Contact Us',
                content:
                    'If you have questions about this Privacy Policy or the Heritage Walks application, please use the Help & Support section of the application.',
              ),

              const SizedBox(height: 12),

              // ======================================================
              // FOOTER
              // ======================================================
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_balance,
                      color: goldColor,
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Heritage Walks',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Discover Sri Lanka',
                      style: TextStyle(
                        color: goldColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '© 2026 Heritage Walks',
                      style: TextStyle(color: Colors.black45, fontSize: 11),
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

  // ================================================================
  // POLICY SECTION
  // ================================================================

  Widget _buildPolicySection({
    required String number,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------------
          // NUMBER
          // --------------------------------------------------------
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0EA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: primaryGreen,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // --------------------------------------------------------
          // CONTENT
          // --------------------------------------------------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: primaryGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    height: 1.6,
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
