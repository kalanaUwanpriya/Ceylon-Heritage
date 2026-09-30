import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserService _userService = UserService();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  String _selectedLocation = 'Sri Lanka';

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _bioController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();

    super.dispose();
  }

  // ============================================================
  // LOAD CURRENT PROFILE FROM FIRESTORE
  // ============================================================

  Future<void> _loadProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in again to edit your profile.'),
        ),
      );

      return;
    }

    try {
      final snapshot = await _userService.getUserProfile(user.uid);

      if (!snapshot.exists || snapshot.data() == null) {
        if (!mounted) return;

        setState(() {
          _nameController.text = user.displayName?.trim().isNotEmpty == true
              ? user.displayName!.trim()
              : '';

          _emailController.text = user.email ?? '';

          _phoneController.text = '';
          _bioController.text = '';
          _selectedLocation = 'Sri Lanka';

          _isLoading = false;
        });

        return;
      }

      final data = snapshot.data()!;

      final nameValue = data['name'];
      final emailValue = data['email'];
      final phoneValue = data['phone'];
      final bioValue = data['bio'];
      final locationValue = data['location'];

      final String firestoreName = nameValue is String ? nameValue.trim() : '';

      final String firestoreEmail = emailValue is String
          ? emailValue.trim()
          : '';

      final String firestorePhone = phoneValue is String
          ? phoneValue.trim()
          : '';

      final String firestoreBio = bioValue is String ? bioValue.trim() : '';

      final String firestoreLocation = locationValue is String
          ? locationValue.trim()
          : '';

      if (!mounted) return;

      setState(() {
        _nameController.text = firestoreName.isNotEmpty
            ? firestoreName
            : (user.displayName?.trim().isNotEmpty == true
                  ? user.displayName!.trim()
                  : '');

        _emailController.text = firestoreEmail.isNotEmpty
            ? firestoreEmail
            : (user.email ?? '');

        _phoneController.text = firestorePhone;

        _bioController.text = firestoreBio;

        _selectedLocation = firestoreLocation.isNotEmpty
            ? firestoreLocation
            : 'Sri Lanka';

        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to load profile: $e')));
    }
  }

  // ============================================================
  // SAVE PROFILE TO FIRESTORE
  // ============================================================

  Future<void> _saveProfile() async {
    if (_isSaving) return;

    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in again to update your profile.'),
        ),
      );

      return;
    }

    final String name = _nameController.text.trim();

    final String phone = _phoneController.text.trim();

    final String bio = _bioController.text.trim();

    // ------------------------------------------------------------
    // NAME VALIDATION
    // ------------------------------------------------------------

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your full name.')),
      );

      return;
    }

    // ------------------------------------------------------------
    // BIO VALIDATION
    // ------------------------------------------------------------

    if (bio.length > 150) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bio must be 150 characters or less.')),
      );

      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await _userService.updateUserProfile(
        uid: user.uid,
        data: {
          'name': name,
          'phone': phone,
          'bio': bio,
          'location': _selectedLocation,
        },
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

      // Return true so ProfileScreen reloads Firestore data.
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // ============================================================
  // LOCATION PICKER
  // ============================================================

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF7F2E8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final locations = [
          'Sri Lanka',
          'Polonnaruwa',
          'Jaffna',
          'Down South',
          'Kandy',
          'Colombo',
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9AD97),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Select Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF294D20),
                  ),
                ),

                const SizedBox(height: 10),

                ...locations.map((location) {
                  return ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF15543A),
                    ),

                    title: Text(
                      location,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF354438),
                      ),
                    ),

                    trailing: location == _selectedLocation
                        ? const Icon(Icons.check, color: Color(0xFF15543A))
                        : null,

                    onTap: () {
                      setState(() {
                        _selectedLocation = location;
                      });

                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // PROFILE PHOTO
  // ============================================================

  void _changeProfilePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile photo upload will be connected later.'),
      ),
    );
  }

  // ============================================================
  // PROFILE FIELD
  // ============================================================

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    int maxLines = 1,
    Widget? suffix,
  }) {
    return Container(
      width: double.infinity,

      constraints: BoxConstraints(minHeight: maxLines > 1 ? 76 : 57),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFE2D7C4)),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),

        child: Row(
          crossAxisAlignment: maxLines > 1
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,

          children: [
            Container(
              width: 34,
              height: 34,

              margin: const EdgeInsets.only(top: 2),

              decoration: BoxDecoration(
                color: const Color(0xFFE8F0E3),
                borderRadius: BorderRadius.circular(8),
              ),

              child: Icon(icon, size: 17, color: const Color(0xFF315E46)),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF777064),
                    ),
                  ),

                  const SizedBox(height: 1),

                  TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    readOnly: readOnly,
                    maxLines: maxLines,

                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF252A26),
                      fontWeight: FontWeight.w500,
                    ),

                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),

            ?suffix,
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LOCATION FIELD
  // ============================================================

  Widget _buildLocationField() {
    return GestureDetector(
      onTap: _showLocationPicker,

      child: Container(
        width: double.infinity,
        height: 57,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: const Color(0xFFE2D7C4)),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),

          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,

                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0E3),
                  borderRadius: BorderRadius.circular(8),
                ),

                child: const Icon(
                  Icons.location_on_outlined,
                  size: 17,
                  color: Color(0xFF315E46),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(fontSize: 8, color: Color(0xFF777064)),
                    ),

                    const SizedBox(height: 1),

                    Text(
                      _selectedLocation,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF252A26),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.keyboard_arrow_down,
                size: 19,
                color: Color(0xFF53624E),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAV ITEM
  // ============================================================

  Widget _buildBottomItem({
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label page will be connected later.')),
          );
        }
      },

      child: SizedBox(
        width: 50,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              width: selected ? 31 : 26,
              height: selected ? 27 : 24,

              decoration: selected
                  ? BoxDecoration(
                      color: const Color(0xFF15543A),
                      borderRadius: BorderRadius.circular(7),
                    )
                  : null,

              child: Icon(
                icon,
                size: selected ? 15 : 16,
                color: selected ? Colors.white : const Color(0xFF607365),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              label,
              style: TextStyle(
                fontSize: 7,
                color: selected
                    ? const Color(0xFF15543A)
                    : const Color(0xFF607365),
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 57,

      decoration: const BoxDecoration(
        color: Color(0xFFF9F4E9),

        border: Border(top: BorderSide(color: Color(0xFFE1D7C5), width: 0.7)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          _buildBottomItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: false,
          ),

          _buildBottomItem(
            icon: Icons.grid_view_outlined,
            label: 'Services',
            selected: false,
          ),

          _buildBottomItem(
            icon: Icons.favorite_border,
            label: 'Saved',
            selected: false,
          ),

          _buildBottomItem(
            icon: Icons.person_outline,
            label: 'Profile',
            selected: true,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2E8),

      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF15543A)),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      child: Column(
                        children: [
                          // ==================================================
                          // HEADER
                          // ==================================================

                          SizedBox(
                            height: 135,
                            width: double.infinity,

                            child: Stack(
                              clipBehavior: Clip.none,

                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    'assets/images/edit_profile_header.png',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ),

                                // BACK BUTTON
                                Positioned(
                                  left: 12,
                                  top: 10,

                                  child: _buildHeaderButton(
                                    icon: Icons.arrow_back,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),

                                // HELP BUTTON
                                Positioned(
                                  right: 12,
                                  top: 10,

                                  child: _buildHeaderButton(
                                    icon: Icons.help_outline,
                                    onTap: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Help & Support will be added later.',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // PROFILE IMAGE
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: -43,

                                  child: Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 88,
                                          height: 88,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color(0xFFD7C8AC),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 4,
                                            ),
                                          ),

                                          child: const Icon(
                                            Icons.person,
                                            size: 48,
                                            color: Color(0xFF60705D),
                                          ),
                                        ),

                                        Positioned(
                                          right: 0,
                                          bottom: 1,

                                          child: GestureDetector(
                                            onTap: _changeProfilePhoto,

                                            child: Container(
                                              width: 28,
                                              height: 28,

                                              decoration: BoxDecoration(
                                                color: const Color(0xFF15543A),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),

                                              child: const Icon(
                                                Icons.camera_alt_outlined,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 50),

                          // ==================================================
                          // CURRENT NAME
                          // ==================================================
                          Text(
                            _nameController.text.isEmpty
                                ? 'Heritage Explorer'
                                : _nameController.text,

                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF294D20),
                            ),
                          ),

                          const SizedBox(height: 2),

                          // CURRENT LOCATION
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 10,
                                color: Color(0xFF65705F),
                              ),

                              const SizedBox(width: 3),

                              Text(
                                _selectedLocation,

                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF65705F),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // ==================================================
                          // FORM
                          // ==================================================
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),

                            child: Column(
                              children: [
                                // FULL NAME
                                _buildProfileField(
                                  icon: Icons.person_outline,
                                  label: 'Full Name',
                                  controller: _nameController,
                                ),

                                const SizedBox(height: 8),

                                // EMAIL
                                _buildProfileField(
                                  icon: Icons.mail_outline,
                                  label: 'Email Address',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  readOnly: true,
                                ),

                                const SizedBox(height: 8),

                                // PHONE
                                _buildProfileField(
                                  icon: Icons.phone_outlined,
                                  label: 'Phone Number',
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                ),

                                const SizedBox(height: 8),

                                // BIO
                                _buildProfileField(
                                  icon: Icons.article_outlined,
                                  label: 'Bio',
                                  controller: _bioController,
                                  maxLines: 2,

                                  suffix: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 2,
                                      bottom: 2,
                                    ),

                                    child: Align(
                                      alignment: Alignment.bottomRight,

                                      child: Text(
                                        '${_bioController.text.length}/150',

                                        style: const TextStyle(
                                          fontSize: 7,
                                          color: Color(0xFF777064),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // LOCATION
                                _buildLocationField(),

                                const SizedBox(height: 15),

                                // ==================================================
                                // SAVE BUTTON
                                // ==================================================
                                SizedBox(
                                  width: double.infinity,
                                  height: 42,

                                  child: ElevatedButton(
                                    onPressed: _isSaving ? null : _saveProfile,

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF15543A),

                                      disabledBackgroundColor: const Color(
                                        0xFF9BB0A4,
                                      ),

                                      foregroundColor: Colors.white,

                                      elevation: 0,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),

                                    child: _isSaving
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            'Save Changes',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // ==================================================
                                // CANCEL
                                // ==================================================
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,

                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },

                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFF31512A),

                                      side: const BorderSide(
                                        color: Color(0xFF31512A),
                                        width: 1,
                                      ),

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),

                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  _buildBottomNavigation(),
                ],
              ),
      ),
    );
  }

  // ============================================================
  // HEADER BUTTON
  // ============================================================

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 31,
        height: 31,

        decoration: BoxDecoration(
          color: const Color(0xFFFDFBF4).withValues(alpha: 0.92),

          shape: BoxShape.circle,
        ),

        child: Icon(icon, size: 16, color: const Color(0xFF31512A)),
      ),
    );
  }
}
