import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../services/user_service.dart';

import 'about_app_screen.dart';

import 'change_password_screen.dart';

import 'edit_profile_screen.dart';

import 'help_support_screen.dart';

import 'login_screen.dart';

import 'notification_settings_screen.dart';

import 'privacy_policy_screen.dart';

import 'visited_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ============================================================

  // HERITAGE WALKS DESIGN COLORS

  // ============================================================

  static const Color backgroundColor = Color(0xFFF6EADA);

  static const Color primaryColor = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color accentColor = Color(0xFF9F5625);

  static const Color secondaryTextColor = Color(0xFF5F625D);

  final UserService _userService = UserService();

  bool _isLoading = true;

  bool _isRefreshing = false;

  String? _errorMessage;

  String _name = 'Heritage Explorer';

  String _email = '';

  String _bio = '';

  String _location = 'Sri Lanka';

  String _profilePhoto = '';

  @override
  void initState() {
    super.initState();

    _loadProfile();
  }

  // ============================================================

  // LOAD PROFILE FROM FIRESTORE

  // ============================================================

  Future<void> _loadProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;

        _errorMessage = 'No logged-in user found.';
      });

      return;
    }

    try {
      final snapshot = await _userService.getUserProfile(user.uid);

      // --------------------------------------------------------

      // IF FIRESTORE PROFILE DOES NOT EXIST

      // --------------------------------------------------------

      if (!snapshot.exists || snapshot.data() == null) {
        if (!mounted) return;

        setState(() {
          _name = user.displayName?.trim().isNotEmpty == true
              ? user.displayName!.trim()
              : 'Heritage Explorer';

          _email = user.email ?? '';

          _bio = '';

          _location = 'Sri Lanka';

          _profilePhoto = '';

          _isLoading = false;

          _errorMessage = null;
        });

        return;
      }

      // --------------------------------------------------------

      // GET FIRESTORE DATA

      // --------------------------------------------------------

      final data = snapshot.data()!;

      final nameValue = data['name'];

      final emailValue = data['email'];

      final bioValue = data['bio'];

      final locationValue = data['location'];

      final profilePhotoValue = data['profilePhoto'];

      final String firestoreName = nameValue is String ? nameValue.trim() : '';

      final String firestoreEmail = emailValue is String
          ? emailValue.trim()
          : '';

      final String firestoreBio = bioValue is String ? bioValue.trim() : '';

      final String firestoreLocation = locationValue is String
          ? locationValue.trim()
          : '';

      final String firestoreProfilePhoto = profilePhotoValue is String
          ? profilePhotoValue.trim()
          : '';

      if (!mounted) return;

      // --------------------------------------------------------

      // UPDATE SCREEN

      // --------------------------------------------------------

      setState(() {
        _name = firestoreName.isNotEmpty
            ? firestoreName
            : (user.displayName?.trim().isNotEmpty == true
                  ? user.displayName!.trim()
                  : 'Heritage Explorer');

        _email = firestoreEmail.isNotEmpty
            ? firestoreEmail
            : (user.email ?? '');

        _bio = firestoreBio;

        _location = firestoreLocation.isNotEmpty
            ? firestoreLocation
            : 'Sri Lanka';

        _profilePhoto = firestoreProfilePhoto;

        _isLoading = false;

        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;

        _errorMessage = 'Unable to load profile.';
      });
    }
  }

  // ============================================================

  // REFRESH PROFILE WITH SMALL VISIBLE ANIMATION

  Future<void> _refreshProfile() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    final minimumAnimation = Future<void>.delayed(
      const Duration(milliseconds: 650),
    );

    await Future.wait<void>([_loadProfile(), minimumAnimation]);

    if (!mounted) return;

    setState(() {
      _isRefreshing = false;
    });
  }

  // OPEN EDIT PROFILE

  // ============================================================

  Future<void> _openEditProfile() async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );

    if (!mounted) return;

    await _loadProfile();
  }

  // ============================================================

  // LOGOUT

  // ============================================================

  Future<void> _showLogoutDialog() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: Text(
            'Logout',

            style: GoogleFonts.playfairDisplay(
              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: primaryColor,
            ),
          ),

          content: Text(
            'Are you sure you want to logout?',

            style: GoogleFonts.inter(fontSize: 14, color: secondaryTextColor),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: Text(
                'Cancel',

                style: GoogleFonts.inter(
                  color: secondaryTextColor,

                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,

                foregroundColor: Colors.white,

                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              child: Text(
                'Logout',

                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    // Sign out from Firebase Authentication.

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    // Remove all previous screens and open Login Screen.

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),

      (route) => false,
    );
  }

  // ============================================================

  // MAIN BUILD

  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : _buildProfileContent(),
      ),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ============================================================

  // PROFILE CONTENT

  // ============================================================

  Widget _buildProfileContent() {
    return RefreshIndicator(
      color: primaryColor,

      onRefresh: _loadProfile,

      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ==================================================

            // HEADER

            // ==================================================
            Row(
              children: [
                Expanded(
                  child: Text(
                    'My Profile',

                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,

                      fontWeight: FontWeight.bold,

                      color: primaryColor,
                    ),
                  ),
                ),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _isRefreshing
                      ? const SizedBox(
                          key: ValueKey('refreshing'),
                          width: 48,
                          height: 48,
                          child: Padding(
                            padding: EdgeInsets.all(13),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: primaryColor,
                            ),
                          ),
                        )
                      : IconButton(
                          key: const ValueKey('refreshButton'),
                          onPressed: _refreshProfile,
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: primaryColor,
                          ),
                          tooltip: 'Refresh profile',
                        ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================

            // ERROR MESSAGE

            // ==================================================
            if (_errorMessage != null)
              Container(
                width: double.infinity,

                margin: const EdgeInsets.only(bottom: 15),

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: Colors.red.shade100),
                ),

                child: Text(
                  _errorMessage!,

                  style: GoogleFonts.inter(
                    color: Colors.red.shade700,

                    fontSize: 13,
                  ),
                ),
              ),

            // ==================================================

            // PROFILE CARD

            // ==================================================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: cardColor,

                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),

                    blurRadius: 12,

                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [
                  _buildProfileAvatar(),

                  const SizedBox(height: 15),

                  Text(
                    _name,

                    textAlign: TextAlign.center,

                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,

                      fontWeight: FontWeight.bold,

                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  if (_email.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Icon(
                          Icons.email_outlined,

                          size: 16,

                          color: secondaryTextColor,
                        ),

                        const SizedBox(width: 6),

                        Flexible(
                          child: Text(
                            _email,

                            overflow: TextOverflow.ellipsis,

                            style: GoogleFonts.inter(
                              fontSize: 14,

                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Icon(
                        Icons.location_on_outlined,

                        size: 17,

                        color: accentColor,
                      ),

                      const SizedBox(width: 5),

                      Flexible(
                        child: Text(
                          _location,

                          textAlign: TextAlign.center,

                          style: GoogleFonts.inter(
                            fontSize: 14,

                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_bio.isNotEmpty) ...[
                    const SizedBox(height: 12),

                    Text(
                      _bio,

                      textAlign: TextAlign.center,

                      style: GoogleFonts.inter(
                        fontSize: 14,

                        color: secondaryTextColor,

                        height: 1.5,
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,

                    height: 48,

                    child: ElevatedButton.icon(
                      onPressed: _openEditProfile,

                      icon: const Icon(Icons.edit_outlined, size: 19),

                      label: Text(
                        'Edit Profile',

                        style: GoogleFonts.inter(
                          fontSize: 14,

                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,

                        foregroundColor: Colors.white,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================

            // MY ACCOUNT

            // ==================================================
            _buildSectionHeading('My Account'),

            const SizedBox(height: 12),

            // SAVED PLACES
            _buildMenuCard(
              icon: Icons.bookmark_outline,

              title: 'Saved Places',

              onTap: () {
                _showComingSoon('Saved Places');
              },
            ),

            // VISITED HISTORY
            _buildMenuCard(
              icon: Icons.history,

              title: 'Visited History',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const VisitedHistoryScreen(),
                  ),
                );
              },
            ),

            // MY REVIEWS
            _buildMenuCard(
              icon: Icons.star_outline,

              title: 'My Reviews',

              onTap: () {
                _showComingSoon('My Reviews');
              },
            ),

            const SizedBox(height: 20),

            // ==================================================

            // SETTINGS

            // ==================================================
            _buildSectionHeading('Settings'),

            const SizedBox(height: 12),

            // LANGUAGE SETTING
            // Temporarily hidden from the Profile UI.
            // Keep this code so it can be enabled again later.
            /*
            _buildMenuCard(
              icon: Icons.language,
              title: 'Language Setting',
              onTap: () {
                _showComingSoon('Language Setting');
              },
            ),
            */

            // NOTIFICATION SETTING
            _buildMenuCard(
              icon: Icons.notifications_none,

              title: 'Notification Setting',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const NotificationSettingsScreen(),
                  ),
                );
              },
            ),

            // CHANGE PASSWORD
            _buildMenuCard(
              icon: Icons.lock_outline,

              title: 'Change Password',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen(),
                  ),
                );
              },
            ),

            // HELP & SUPPORT
            _buildMenuCard(
              icon: Icons.help_outline,

              title: 'Help & Support',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const HelpSupportScreen(),
                  ),
                );
              },
            ),

            // ABOUT APP
            _buildMenuCard(
              icon: Icons.info_outline,

              title: 'About App',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const AboutAppScreen(),
                  ),
                );
              },
            ),

            // PRIVACY POLICY
            _buildMenuCard(
              icon: Icons.privacy_tip_outlined,

              title: 'Privacy Policy',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // ==================================================

            // LOGOUT

            // ==================================================
            SizedBox(
              width: double.infinity,

              height: 52,

              child: OutlinedButton.icon(
                onPressed: _showLogoutDialog,

                icon: const Icon(Icons.logout, color: Colors.red),

                label: Text(
                  'Logout',

                  style: GoogleFonts.inter(
                    color: Colors.red,

                    fontWeight: FontWeight.w600,

                    fontSize: 14,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  backgroundColor: backgroundColor,

                  side: const BorderSide(color: Colors.red, width: 1.2),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // ============================================================

  // SECTION HEADING

  // ============================================================

  Widget _buildSectionHeading(String title) {
    return Text(
      title,

      style: GoogleFonts.playfairDisplay(
        fontSize: 20,

        fontWeight: FontWeight.bold,

        color: primaryColor,
      ),
    );
  }

  // ============================================================

  // PROFILE AVATAR

  // ============================================================

  Widget _buildProfileAvatar() {
    if (_profilePhoto.isNotEmpty) {
      final File profileFile = File(_profilePhoto);

      if (profileFile.existsSync()) {
        return Container(
          padding: const EdgeInsets.all(3),

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            border: Border.all(color: accentColor, width: 2),
          ),

          child: CircleAvatar(
            radius: 48,

            backgroundImage: FileImage(profileFile),

            backgroundColor: backgroundColor,
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(3),

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(color: accentColor, width: 2),
      ),

      child: const CircleAvatar(
        radius: 48,

        backgroundColor: backgroundColor,

        child: Icon(Icons.person_outline, size: 52, color: primaryColor),
      ),
    );
  }

  // ============================================================

  // MENU CARD

  // ============================================================

  Widget _buildMenuCard({
    required IconData icon,

    required String title,

    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        onTap: onTap,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

        leading: Container(
          width: 42,

          height: 42,

          decoration: BoxDecoration(
            color: backgroundColor,

            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(icon, color: primaryColor, size: 22),
        ),

        title: Text(
          title,

          style: GoogleFonts.inter(
            fontSize: 16,

            fontWeight: FontWeight.w600,

            color: primaryColor,
          ),
        ),

        trailing: const Icon(Icons.chevron_right_rounded, color: accentColor),
      ),
    );
  }

  // ============================================================

  // COMING SOON

  // ============================================================

  void _showComingSoon(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$featureName will be connected next.',

          style: GoogleFonts.inter(),
        ),

        backgroundColor: primaryColor,

        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================

  // BOTTOM NAVIGATION

  // ============================================================

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: 3,

      type: BottomNavigationBarType.fixed,

      backgroundColor: backgroundColor,

      selectedItemColor: primaryColor,

      unselectedItemColor: secondaryTextColor,

      selectedFontSize: 13,

      unselectedFontSize: 13,

      selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),

      unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),

      elevation: 8,

      onTap: (index) {
        if (index == 3) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Navigation will be connected next.',

              style: GoogleFonts.inter(),
            ),

            backgroundColor: primaryColor,

            duration: const Duration(seconds: 1),
          ),
        );
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),

          activeIcon: Icon(Icons.home),

          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),

          activeIcon: Icon(Icons.grid_view_outlined),

          label: 'Services',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded, size: 27),

          activeIcon: Icon(Icons.favorite_rounded, size: 27),

          label: 'Saved',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),

          activeIcon: Icon(Icons.person),

          label: 'Profile',
        ),
      ],
    );
  }
}
