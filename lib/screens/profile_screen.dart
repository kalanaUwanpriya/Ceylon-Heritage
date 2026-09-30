import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();

  bool _isLoading = true;
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
  // OPEN EDIT PROFILE
  // ============================================================

  Future<void> _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );

    // Edit Profile returns true after successful save.
    if (result == true) {
      await _loadProfile();
    }
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> _showLogoutDialog() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A2B),
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EB),

      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF1E3A2B)),
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
      color: const Color(0xFF1E3A2B),

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
                const Expanded(
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A2B),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: _loadProfile,
                  icon: const Icon(Icons.refresh, color: Color(0xFF1E3A2B)),
                  tooltip: 'Refresh profile',
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
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                ),
              ),

            // ==================================================
            // PROFILE CARD
            // ==================================================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // PROFILE PHOTO
                  _buildProfileAvatar(),

                  const SizedBox(height: 15),

                  // ==================================================
                  // NAME
                  // ==================================================
                  Text(
                    _name,

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A2B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================================
                  // EMAIL
                  // ==================================================
                  if (_email.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 6),

                        Flexible(
                          child: Text(
                            _email,

                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 6),

                  // ==================================================
                  // LOCATION
                  // ==================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: Color(0xFFC88E38),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        _location,

                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // ==================================================
                  // BIO
                  // ==================================================
                  if (_bio.isNotEmpty) ...[
                    const SizedBox(height: 12),

                    Text(
                      _bio,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF555555),
                        height: 1.4,
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // ==================================================
                  // EDIT PROFILE
                  // ==================================================
                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton.icon(
                      onPressed: _openEditProfile,

                      icon: const Icon(Icons.edit_outlined, size: 19),

                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A2B),

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
            const Text(
              'My Account',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A2B),
              ),
            ),

            const SizedBox(height: 12),

            _buildMenuCard(
              icon: Icons.bookmark_outline,
              title: 'Saved Places',
              onTap: () {
                _showComingSoon('Saved Places');
              },
            ),

            _buildMenuCard(
              icon: Icons.history,
              title: 'Visited History',
              onTap: () {
                _showComingSoon('Visited History');
              },
            ),

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
            const Text(
              'Settings',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A2B),
              ),
            ),

            const SizedBox(height: 12),

            _buildMenuCard(
              icon: Icons.language,
              title: 'Language Setting',
              onTap: () {
                _showComingSoon('Language Setting');
              },
            ),

            _buildMenuCard(
              icon: Icons.notifications_none,
              title: 'Notification Setting',
              onTap: () {
                _showComingSoon('Notification Setting');
              },
            ),

            _buildMenuCard(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () {
                _showComingSoon('Change Password');
              },
            ),

            _buildMenuCard(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                _showComingSoon('Help & Support');
              },
            ),

            _buildMenuCard(
              icon: Icons.info_outline,
              title: 'About App',
              onTap: () {
                _showComingSoon('About App');
              },
            ),

            _buildMenuCard(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {
                _showComingSoon('Privacy Policy');
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

                label: const Text(
                  'Logout',

                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: OutlinedButton.styleFrom(
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
  // PROFILE AVATAR
  // ============================================================

  Widget _buildProfileAvatar() {
    if (_profilePhoto.isNotEmpty) {
      return CircleAvatar(
        radius: 48,

        backgroundImage: NetworkImage(_profilePhoto),

        backgroundColor: const Color(0xFFE9E1D5),
      );
    }

    return const CircleAvatar(
      radius: 48,

      backgroundColor: Color(0xFFE9E1D5),

      child: Icon(Icons.person, size: 52, color: Color(0xFF1E3A2B)),
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
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),

        leading: Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: const Color(0xFFF1EDE6),

            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(icon, color: const Color(0xFF1E3A2B), size: 22),
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),

        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

  // ============================================================
  // COMING SOON
  // ============================================================

  void _showComingSoon(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName will be connected next.'),

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

      backgroundColor: Colors.white,

      selectedItemColor: const Color(0xFF1E3A2B),

      unselectedItemColor: Colors.grey,

      selectedFontSize: 12,

      unselectedFontSize: 12,

      onTap: (index) {
        if (index == 3) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Navigation will be connected next.'),

            duration: Duration(seconds: 1),
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
          icon: Icon(Icons.explore_outlined),

          activeIcon: Icon(Icons.explore),

          label: 'Explore',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),

          activeIcon: Icon(Icons.bookmark),

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
