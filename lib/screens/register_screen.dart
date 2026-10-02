import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import '../services/user_service.dart';

import 'home_screen.dart';

import 'login_screen.dart';

import 'privacy_policy_screen.dart';

import 'terms_of_service_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  final UserService _userService = UserService();

  bool _isLoading = false;

  bool _obscurePassword = true;

  bool _obscureConfirmPassword = true;

  bool _acceptedTerms = false;

  // =========================================================

  // DESIGN COLORS

  // =========================================================

  static const Color primaryColor = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color borderColor = Color(0xFFD6C4AA);

  static const Color textColor = Color(0xFF302B23);

  static const Color hintColor = Color(0xFF7B756A);

  // =========================================================

  // EMAIL / PASSWORD REGISTER

  // =========================================================

  Future<void> _register() async {
    final name = _nameController.text.trim();

    final email = _emailController.text.trim();

    final phone = _phoneController.text.trim();

    final password = _passwordController.text;

    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );

      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must contain at least 6 characters.'),
        ),
      );

      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match.')));

      return;
    }

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please agree to the Terms of Service and Privacy Policy.',
          ),
        ),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _authService.register(
        email: email,

        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception('Account creation failed.');
      }

      await _userService.createUserProfile(
        uid: user.uid,

        name: name,

        email: email,

        phone: phone,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(builder: (context) => const HomeScreen()),

        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account already exists with this email.';

          break;

        case 'invalid-email':
          message = 'Please enter a valid email address.';

          break;

        case 'weak-password':
          message = 'Password is too weak.';

          break;

        case 'operation-not-allowed':
          message = 'Email registration is currently disabled.';

          break;

        case 'network-request-failed':
          message = 'Please check your internet connection.';

          break;

        default:
          message = 'Registration failed. Please try again.';
      }

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // =========================================================

  // GOOGLE REGISTER / SIGN IN

  // =========================================================

  Future<void> _googleRegister() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _authService.signInWithGoogle();

      if (!mounted) return;

      if (userCredential == null) {
        return;
      }

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Google user information was not found.');
      }

      final profile = await _userService.getUserProfile(user.uid);

      if (!profile.exists) {
        await _userService.createUserProfile(
          uid: user.uid,

          name: user.displayName ?? 'Heritage Walks User',

          email: user.email ?? '',

          phone: '',
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in successful!')),
      );

      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(builder: (context) => const HomeScreen()),

        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Google sign-in failed.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google sign-in failed: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // =========================================================

  // OPEN LOGIN

  // =========================================================

  void _openLogin() {
    Navigator.pushReplacement(
      context,

      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // =========================================================

  // DISPOSE

  // =========================================================

  @override
  void dispose() {
    _nameController.dispose();

    _emailController.dispose();

    _phoneController.dispose();

    _passwordController.dispose();

    _confirmPasswordController.dispose();

    super.dispose();
  }

  // =========================================================

  // UI

  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'),

              fit: BoxFit.cover,

              alignment: Alignment.center,
            ),
          ),

          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,

                        vertical: 10,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // =====================================

                          // BACK

                          // =====================================
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            padding: EdgeInsets.zero,

                            constraints: const BoxConstraints(),

                            icon: const Icon(
                              Icons.arrow_back,

                              size: 24,

                              color: primaryColor,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // =====================================

                          // TITLE

                          // =====================================
                          const Text(
                            'Create Your Account',

                            style: TextStyle(
                              fontSize: 24,

                              fontWeight: FontWeight.bold,

                              color: primaryColor,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            'Start exploring Sri Lanka’s Heritage',

                            style: TextStyle(fontSize: 13, color: textColor),
                          ),

                          const SizedBox(height: 20),

                          // =====================================

                          // FULL NAME

                          // =====================================
                          _buildTextField(
                            controller: _nameController,

                            hintText: 'Enter your full name',

                            icon: Icons.person_outline,
                          ),

                          const SizedBox(height: 9),

                          // =====================================

                          // EMAIL

                          // =====================================
                          _buildTextField(
                            controller: _emailController,

                            hintText: 'example@gmail.com',

                            icon: Icons.mail_outline,

                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 9),

                          // =====================================

                          // PHONE

                          // =====================================
                          _buildTextField(
                            controller: _phoneController,

                            hintText: 'Phone number',

                            icon: Icons.phone_outlined,

                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: 9),

                          // =====================================

                          // PASSWORD

                          // =====================================
                          _buildPasswordField(
                            controller: _passwordController,

                            hintText: 'Create Password',

                            obscureText: _obscurePassword,

                            onToggle: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),

                          const SizedBox(height: 9),

                          // =====================================

                          // CONFIRM PASSWORD

                          // =====================================
                          _buildPasswordField(
                            controller: _confirmPasswordController,

                            hintText: 'Confirm Your Password',

                            obscureText: _obscureConfirmPassword,

                            onToggle: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),

                          const SizedBox(height: 10),

                          // =====================================

                          // TERMS

                          // =====================================
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              SizedBox(
                                width: 24,

                                height: 24,

                                child: Checkbox(
                                  value: _acceptedTerms,

                                  activeColor: primaryColor,

                                  side: const BorderSide(
                                    color: primaryColor,

                                    width: 1.5,
                                  ),

                                  onChanged: (value) {
                                    setState(() {
                                      _acceptedTerms = value ?? false;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(width: 7),

                              Expanded(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text(
                                      'I agree to the ',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: textColor,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TermsOfServiceScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Terms of Service',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      ' & ',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: textColor,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyPolicyScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // =====================================

                          // CREATE ACCOUNT

                          // =====================================
                          SizedBox(
                            width: double.infinity,

                            height: 46,

                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _register,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,

                                foregroundColor: Colors.white,

                                disabledBackgroundColor: primaryColor
                                    .withValues(alpha: 0.65),

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),

                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,

                                      height: 20,

                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,

                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Create Account  →',

                                      style: TextStyle(
                                        fontFamily: 'serif',

                                        fontSize: 14,

                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // =====================================

                          // OR

                          // =====================================
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,

                                  color: const Color(0xFF9C978B),
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),

                                child: Text(
                                  'or',

                                  style: TextStyle(
                                    fontSize: 12,

                                    color: hintColor,
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  height: 1,

                                  color: const Color(0xFF9C978B),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // =====================================

                          // GOOGLE BUTTON

                          // =====================================
                          Center(
                            child: SizedBox(
                              width: 230,

                              height: 46,

                              child: OutlinedButton(
                                onPressed: _isLoading ? null : _googleRegister,

                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.94,
                                  ),

                                  foregroundColor: const Color(0xFF3C4043),

                                  side: const BorderSide(
                                    color: Color(0xFFDADCE0),

                                    width: 1,
                                  ),

                                  elevation: 0,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),

                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    // Google-style G mark

                                    Container(
                                      width: 24,

                                      height: 24,

                                      alignment: Alignment.center,

                                      decoration: const BoxDecoration(
                                        color: Colors.white,

                                        shape: BoxShape.circle,
                                      ),

                                      child: const Text(
                                        'G',

                                        style: TextStyle(
                                          color: Color(0xFF4285F4),

                                          fontSize: 19,

                                          fontWeight: FontWeight.w700,

                                          fontFamily: 'Arial',
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    const Text(
                                      'Continue with Google',

                                      style: TextStyle(
                                        fontSize: 13,

                                        color: Color(0xFF3C4043),

                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // =====================================

                          // LOGIN

                          // =====================================
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,

                              children: [
                                const Text(
                                  'Already Have an Account? ',

                                  style: TextStyle(
                                    fontSize: 11,

                                    color: textColor,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: _openLogin,

                                  child: const Text(
                                    'Log In',

                                    style: TextStyle(
                                      fontSize: 11,

                                      fontWeight: FontWeight.bold,

                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================

  // NORMAL TEXT FIELD

  // =========================================================

  Widget _buildTextField({
    required TextEditingController controller,

    required String hintText,

    required IconData icon,

    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: borderColor, width: 1),
      ),

      child: TextField(
        controller: controller,

        keyboardType: keyboardType,

        style: const TextStyle(fontSize: 13, color: textColor),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: hintText,

          hintStyle: const TextStyle(fontSize: 13, color: hintColor),

          prefixIcon: Icon(icon, size: 20, color: hintColor),

          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // =========================================================

  // PASSWORD FIELD

  // =========================================================

  Widget _buildPasswordField({
    required TextEditingController controller,

    required String hintText,

    required bool obscureText,

    required VoidCallback onToggle,
  }) {
    return Container(
      height: 48,

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: borderColor, width: 1),
      ),

      child: TextField(
        controller: controller,

        obscureText: obscureText,

        style: const TextStyle(fontSize: 13, color: textColor),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: hintText,

          hintStyle: const TextStyle(fontSize: 13, color: hintColor),

          prefixIcon: const Icon(
            Icons.lock_outline,

            size: 20,

            color: hintColor,
          ),

          suffixIcon: IconButton(
            onPressed: onToggle,

            padding: EdgeInsets.zero,

            icon: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,

              size: 21,

              color: hintColor,
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
