import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import '../services/user_service.dart';

import 'home_screen.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  final UserService _userService = UserService();

  bool _isLoading = false;

  bool _isGoogleLoading = false;

  bool _obscurePassword = true;

  // =========================================================

  // DESIGN COLORS

  // =========================================================

  static const Color primaryColor = Color(0xFF17452F);

  static const Color cardColor = Color(0xFFF0DDC3);

  static const Color borderColor = Color(0xFFD6C4AA);

  static const Color textColor = Color(0xFF302B23);

  static const Color hintColor = Color(0xFF7B756A);

  // =========================================================

  // EMAIL / PASSWORD LOGIN

  // =========================================================

  Future<void> _login() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email and password.')),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.login(
        email: _emailController.text.trim(),

        password: _passwordController.text,
      );
      final user = _authService.currentUser;

      if (user == null) {
        throw Exception('Unable to verify your account.');
      }

      final isActive = await _userService.isUserActive(user.uid);

      if (!isActive) {
        await _authService.logout();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your account is inactive. Please contact the administrator.',
            ),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successful!')));

      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(builder: (context) => const HomeScreen()),

        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-credential':
          message = 'Invalid email or password.';

          break;

        case 'user-not-found':
          message = 'No account found with this email.';

          break;

        case 'wrong-password':
          message = 'Incorrect password.';

          break;

        case 'invalid-email':
          message = 'Please enter a valid email address.';

          break;

        case 'user-disabled':
          message = 'This account has been disabled.';

          break;

        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';

          break;

        case 'network-request-failed':
          message = 'Please check your internet connection.';

          break;

        default:
          message = 'Login failed. Please try again.';
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

  // GOOGLE LOGIN

  // =========================================================

  Future<void> _googleLogin() async {
    if (_isGoogleLoading) return;

    setState(() {
      _isGoogleLoading = true;
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

      // Check whether this Google user already has a profile.

      final profile = await _userService.getUserProfile(user.uid);

      // Create profile only for a new Google user.

      if (!profile.exists) {
        await _userService.createUserProfile(
          uid: user.uid,

          name: user.displayName ?? 'Heritage Walks User',

          email: user.email ?? '',

          phone: '',
        );
      }
      // Check the account status before opening Home.
      final isActive = await _userService.isUserActive(user.uid);

      if (!isActive) {
        await _authService.logout();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your account is inactive. Please contact the administrator.',
            ),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Google login successful!')));

      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(builder: (context) => const HomeScreen()),

        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Google login failed.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google login failed: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

  // =========================================================

  // FORGOT PASSWORD

  // =========================================================

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email first.')),
      );

      return;
    }

    try {
      await _authService.resetPassword(email);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your email.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Unable to send password reset email.'),
        ),
      );
    }
  }

  // =========================================================

  // OPEN REGISTER

  // =========================================================

  void _openRegister() {
    Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  // =========================================================

  // DISPOSE

  // =========================================================

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

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

                        vertical: 12,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // =====================================

                          // BACK BUTTON

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

                          const SizedBox(height: 42),

                          // =====================================

                          // TITLE

                          // =====================================
                          const Text(
                            'Welcome Back',

                            style: TextStyle(
                              fontSize: 25,

                              fontWeight: FontWeight.bold,

                              color: primaryColor,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Sign in to continue your journey.',

                            style: TextStyle(fontSize: 14, color: textColor),
                          ),

                          const SizedBox(height: 26),

                          // =====================================

                          // EMAIL

                          // =====================================
                          _buildTextField(
                            controller: _emailController,

                            hintText: 'example@gmail.com',

                            icon: Icons.mail_outline,

                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 12),

                          // =====================================

                          // PASSWORD

                          // =====================================
                          _buildPasswordField(),

                          // =====================================

                          // FORGOT PASSWORD

                          // =====================================
                          Align(
                            alignment: Alignment.centerRight,

                            child: TextButton(
                              onPressed: _forgotPassword,

                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  top: 6,

                                  bottom: 4,
                                ),

                                minimumSize: Size.zero,

                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),

                              child: const Text(
                                'Forgot Password?',

                                style: TextStyle(
                                  fontSize: 12,

                                  fontWeight: FontWeight.w600,

                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // =====================================

                          // LOGIN BUTTON

                          // =====================================
                          Center(
                            child: SizedBox(
                              width: 160,

                              height: 46,

                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _login,

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
                                        'Log In',

                                        style: TextStyle(
                                          fontFamily: 'serif',

                                          fontSize: 14,

                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // =====================================

                          // OR DIVIDER

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

                          const SizedBox(height: 18),

                          // =====================================

                          // GOOGLE BUTTON

                          // =====================================
                          Center(
                            child: SizedBox(
                              width: 230,

                              height: 46,

                              child: OutlinedButton(
                                onPressed: _isGoogleLoading
                                    ? null
                                    : _googleLogin,

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

                                child: _isGoogleLoading
                                    ? const SizedBox(
                                        width: 20,

                                        height: 20,

                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,

                                          color: primaryColor,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
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

                          const SizedBox(height: 18),

                          // =====================================

                          // SIGN UP

                          // =====================================
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,

                              children: [
                                const Text(
                                  "Doesn't have an account? ",

                                  style: TextStyle(
                                    fontSize: 11,

                                    color: textColor,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: _openRegister,

                                  child: const Text(
                                    'Signup',

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

                          // TEMPORARY DEVELOPMENT SKIP BUTTON
                          Center(
                            child: TextButton(
                              onPressed: (_isLoading || _isGoogleLoading)
                                  ? null
                                  : () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                              child: const Text(
                                'Skip for Now →',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
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

  // EMAIL FIELD

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

  Widget _buildPasswordField() {
    return Container(
      height: 48,

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: borderColor, width: 1),
      ),

      child: TextField(
        controller: _passwordController,

        obscureText: _obscurePassword,

        style: const TextStyle(fontSize: 13, color: textColor),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: 'Password',

          hintStyle: const TextStyle(fontSize: 13, color: hintColor),

          prefixIcon: const Icon(
            Icons.key_outlined,

            size: 20,

            color: hintColor,
          ),

          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },

            icon: Icon(
              _obscurePassword
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
