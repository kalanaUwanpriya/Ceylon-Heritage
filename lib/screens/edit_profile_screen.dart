import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

import '../services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color backgroundColor = Color(0xFFF6EADA);

  static const Color primaryColor = Color(0xFF17452F);

  static const Color secondaryTextColor = Color(0xFF5F625D);

  final UserService _userService = UserService();

  final ImagePicker _imagePicker = ImagePicker();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _bioController = TextEditingController();

  String _selectedLocation = 'Sri Lanka';

  // Profile picture

  String _profilePhotoUrl = '';

  File? _selectedProfileImage;

  bool _isUploadingPhoto = false;

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

      final profilePhotoValue = data['profilePhoto'];

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

      final String firestoreProfilePhoto = profilePhotoValue is String
          ? profilePhotoValue.trim()
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

        _profilePhotoUrl = firestoreProfilePhoto;

        _selectedProfileImage = null;

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

      backgroundColor: backgroundColor,

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
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),

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
                    dense: true,

                    visualDensity: const VisualDensity(vertical: -2),

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

  Future<void> _changeProfilePhoto() async {
    if (_isUploadingPhoto) return;

    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,

      backgroundColor: const Color(0xFFF6EADA),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),

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

                const SizedBox(height: 16),

                const Text(
                  'Change Profile Photo',

                  style: TextStyle(
                    fontSize: 17,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF17452F),
                  ),
                ),

                const SizedBox(height: 12),

                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,

                    color: Color(0xFF17452F),
                  ),

                  title: const Text('Take a Photo'),

                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),

                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,

                    color: Color(0xFF17452F),
                  ),

                  title: const Text('Choose from Gallery'),

                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: source,

        imageQuality: 80,

        maxWidth: 1200,

        maxHeight: 1200,
      );

      if (pickedImage == null) return;

      final User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please log in again to update your profile photo.'),
          ),
        );

        return;
      }

      if (!mounted) return;

      setState(() {
        _isUploadingPhoto = true;

        _selectedProfileImage = File(pickedImage.path);
      });

      // Get this app's permanent local storage folder.

      final Directory appDirectory = await getApplicationDocumentsDirectory();

      // Create a separate profile photo file for this user.

      final String savedImagePath =
          '${appDirectory.path}/profile_${user.uid}.jpg';

      final File savedImage = await File(pickedImage.path).copy(savedImagePath);

      // Save the permanent local path in the existing profilePhoto field.

      await _userService.updateUserProfile(
        uid: user.uid,

        data: {'profilePhoto': savedImage.path},
      );

      if (!mounted) return;

      setState(() {
        _profilePhotoUrl = savedImage.path;

        _selectedProfileImage = savedImage;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile photo updated successfully!')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to update profile photo: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploadingPhoto = false;
        });
      }
    }
  }

  Widget _buildProfileImage() {
    // Show newly selected photo first.

    if (_selectedProfileImage != null) {
      return ClipOval(
        child: Image.file(
          _selectedProfileImage!,

          width: 88,

          height: 88,

          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 48, color: Color(0xFF60705D));
          },
        ),
      );
    }

    // Show previously saved local profile photo.

    if (_profilePhotoUrl.isNotEmpty) {
      final File savedPhoto = File(_profilePhotoUrl);

      if (savedPhoto.existsSync()) {
        return ClipOval(
          child: Image.file(
            savedPhoto,

            width: 88,

            height: 88,

            fit: BoxFit.cover,

            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person,

                size: 48,

                color: Color(0xFF60705D),
              );
            },
          ),
        );
      }
    }

    // No profile photo.

    return const Icon(Icons.person, size: 48, color: Color(0xFF60705D));
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
    const fieldCardColor = Color(0xFFF0DDC3);

    const accentColor = Color(0xFF9F5625);

    return Container(
      width: double.infinity,

      constraints: BoxConstraints(minHeight: maxLines > 1 ? 90 : 64),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),

      decoration: BoxDecoration(
        color: fieldCardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),

          width: 1,
        ),
      ),

      child: Row(
        crossAxisAlignment: maxLines > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,

        children: [
          Padding(
            padding: EdgeInsets.only(top: maxLines > 1 ? 4 : 0),

            child: Icon(icon, size: 23, color: primaryColor),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  label,

                  style: const TextStyle(
                    fontSize: 12,

                    color: secondaryTextColor,

                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                TextField(
                  controller: controller,

                  keyboardType: keyboardType,

                  readOnly: readOnly,

                  maxLines: maxLines,

                  style: const TextStyle(
                    fontSize: 15,

                    color: primaryColor,

                    fontWeight: FontWeight.w600,
                  ),

                  decoration: const InputDecoration(
                    isDense: true,

                    filled: false,

                    border: InputBorder.none,

                    enabledBorder: InputBorder.none,

                    focusedBorder: InputBorder.none,

                    disabledBorder: InputBorder.none,

                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),

          if (suffix != null) ...[const SizedBox(width: 8), suffix],
        ],
      ),
    );
  }

  // ============================================================

  // LOCATION FIELD

  // ============================================================

  Widget _buildLocationField() {
    const fieldCardColor = Color(0xFFF0DDC3);

    const accentColor = Color(0xFF9F5625);

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: _showLocationPicker,

        borderRadius: BorderRadius.circular(16),

        child: Container(
          width: double.infinity,

          height: 64,

          padding: const EdgeInsets.symmetric(horizontal: 16),

          decoration: BoxDecoration(
            color: fieldCardColor,

            borderRadius: BorderRadius.circular(16),

            border: Border.all(
              color: accentColor.withValues(alpha: 0.22),

              width: 1,
            ),
          ),

          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,

                size: 23,

                color: primaryColor,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Location',

                      style: TextStyle(
                        fontSize: 12,

                        color: secondaryTextColor,

                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      _selectedLocation,

                      style: const TextStyle(
                        fontSize: 15,

                        color: primaryColor,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.keyboard_arrow_down_rounded,

                size: 24,

                color: primaryColor,
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),

        child: Material(
          color: selected ? primaryColor : Colors.transparent,

          borderRadius: BorderRadius.circular(22),

          child: InkWell(
            borderRadius: BorderRadius.circular(22),

            onTap: () {
              if (!selected) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label page will be connected later.'),
                  ),
                );
              }
            },

            child: SizedBox(
              height: 72,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    icon,

                    size: 26,

                    color: selected ? backgroundColor : primaryColor,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    label,

                    style: TextStyle(
                      fontSize: 13,

                      color: selected ? backgroundColor : primaryColor,

                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================

  // BOTTOM NAVIGATION

  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 88,

      padding: const EdgeInsets.symmetric(horizontal: 10),

      decoration: const BoxDecoration(
        color: backgroundColor,

        border: Border(top: BorderSide(color: Color(0xFFD8C4A8), width: 0.8)),
      ),

      child: Row(
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
      backgroundColor: backgroundColor,

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
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        'assets/images/heritage_sketch_bg.jpg',
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                      // Light overlay makes the cover image
                                      // softer so the profile picture stands out.
                                      Container(
                                        color: backgroundColor.withValues(
                                          alpha: 0.28,
                                        ),
                                      ),
                                    ],
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

                                  bottom: 0,

                                  child: Center(
                                    child: Stack(
                                      clipBehavior: Clip.none,

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

                                          child: _buildProfileImage(),
                                        ),

                                        Positioned(
                                          right: 0,

                                          bottom: 1,

                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,

                                            onTap: _changeProfilePhoto,

                                            child: Container(
                                              width: 28,

                                              height: 28,

                                              decoration: BoxDecoration(
                                                color: primaryColor,

                                                shape: BoxShape.circle,

                                                border: Border.all(
                                                  color: Colors.white,

                                                  width: 2,
                                                ),
                                              ),

                                              child: _isUploadingPhoto
                                                  ? const Padding(
                                                      padding: EdgeInsets.all(
                                                        6,
                                                      ),

                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,

                                                            color: Colors.white,
                                                          ),
                                                    )
                                                  : const Icon(
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

                                const SizedBox(height: 7),

                                // EMAIL
                                _buildProfileField(
                                  icon: Icons.mail_outline,

                                  label: 'Email Address',

                                  controller: _emailController,

                                  keyboardType: TextInputType.emailAddress,

                                  readOnly: true,
                                ),

                                const SizedBox(height: 7),

                                // PHONE
                                _buildProfileField(
                                  icon: Icons.phone_outlined,

                                  label: 'Phone Number',

                                  controller: _phoneController,

                                  keyboardType: TextInputType.phone,
                                ),

                                const SizedBox(height: 7),

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
                                          fontSize: 12,

                                          color: Color(0xFF777064),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 7),

                                // LOCATION
                                _buildLocationField(),

                                const SizedBox(height: 15),

                                // ==================================================

                                // SAVE BUTTON

                                // ==================================================
                                SizedBox(
                                  width: double.infinity,

                                  height: 50,

                                  child: ElevatedButton(
                                    onPressed: _isSaving ? null : _saveProfile,

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,

                                      disabledBackgroundColor: const Color(
                                        0xFF9BB0A4,
                                      ),

                                      foregroundColor: Colors.white,

                                      elevation: 0,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
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

                                  height: 48,

                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },

                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: primaryColor,

                                      side: const BorderSide(
                                        color: Color(0xFF31512A),

                                        width: 1,
                                      ),

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
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
          color: backgroundColor.withValues(alpha: 0.94),

          shape: BoxShape.circle,
        ),

        child: Icon(icon, size: 16, color: primaryColor),
      ),
    );
  }
}
