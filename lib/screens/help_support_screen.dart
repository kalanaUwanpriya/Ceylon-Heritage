import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const Color primaryGreen = Color(0xFF1E3A2B);
  static const Color backgroundColor = Color(0xFFF7F2EB);

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
          'Help & Support',
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
              // INTRODUCTION
              // ======================================================
              const Text(
                'How can we help?',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Find answers to common questions or get in touch with our support team.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // ======================================================
              // FAQ SECTION
              // ======================================================
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _buildFaqCard(
                question: 'How do I save a historical place?',
                answer:
                    'Open a historical place and use the Save option to add it to your saved places.',
              ),

              _buildFaqCard(
                question: 'How do I create a walking route?',
                answer:
                    'Open the route planner, select your preferences and create a walking route based on your selected options.',
              ),

              _buildFaqCard(
                question: 'How do I view my visited places?',
                answer:
                    'Go to Profile and select Visited History to see the places you have visited.',
              ),

              _buildFaqCard(
                question: 'How can I change my profile information?',
                answer:
                    'Go to Profile, select Edit Profile, update your information and press Save Changes.',
              ),

              _buildFaqCard(
                question: 'How do I change my password?',
                answer:
                    'Go to Profile and select Change Password. Enter your current password and create a new password.',
              ),

              const SizedBox(height: 24),

              // ======================================================
              // CONTACT US
              // ======================================================
              const Text(
                'Contact Us',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _buildContactCard(
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'heritagewalks@gmail.com',
                onTap: () {
                  _showComingSoon(context, 'Email Support');
                },
              ),

              _buildContactCard(
                icon: Icons.phone_outlined,
                title: 'Phone Support',
                subtitle: '+94 11 234 5678',
                onTap: () {
                  _showComingSoon(context, 'Phone Support');
                },
              ),

              _buildContactCard(
                icon: Icons.location_on_outlined,
                title: 'Location',
                subtitle: 'Sri Lanka',
                onTap: () {},
              ),

              const SizedBox(height: 24),

              // ======================================================
              // SUPPORT MESSAGE
              // ======================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.support_agent, color: primaryGreen, size: 30),

                    SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need more help?',
                            style: TextStyle(
                              color: primaryGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Our support team is here to help you with your Heritage Walks experience.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
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
  // FAQ CARD
  // ================================================================
  Widget _buildFaqCard({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        iconColor: primaryGreen,
        collapsedIconColor: primaryGreen,

        title: Text(
          question,
          style: const TextStyle(
            color: primaryGreen,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // CONTACT CARD
  // ================================================================
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0EA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryGreen),
        ),

        title: Text(
          title,
          style: const TextStyle(
            color: primaryGreen,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.black45,
        ),

        onTap: onTap,
      ),
    );
  }

  // ================================================================
  // TEMPORARY MESSAGE
  // ================================================================
  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$feature will be available soon.')));
  }
}
