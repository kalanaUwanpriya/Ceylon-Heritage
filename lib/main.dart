import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
// TEMPORARY DEVELOPMENT BYPASS
// Restore login_screen.dart before final submission.
// import 'screens/login_screen.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const CeylonHeritageApp());
}

class CeylonHeritageApp extends StatelessWidget {
  const CeylonHeritageApp({super.key});

  // Ceylon Heritage color palette
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color primaryColor = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ceylon Heritage',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: backgroundColor,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          surface: backgroundColor,
        ),

        // Card style
        cardTheme: const CardThemeData(
          color: cardColor,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),

        // Main application typography
        textTheme: TextTheme(
          displayLarge: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          displaySmall: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          headlineLarge: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
          headlineMedium: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
          headlineSmall: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),

          titleLarge: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
          titleMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
          titleSmall: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),

          bodyLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            color: primaryColor,
          ),
          bodyMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            color: primaryColor,
          ),
          bodySmall: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            color: primaryColor,
          ),

          labelLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          labelMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          labelSmall: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
        ),

        // Input fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),

        // Elevated buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Navigation bar
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: cardColor,
          indicatorColor: primaryColor,
          elevation: 0,
          labelTextStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),

        // App bar
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: primaryColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),

      // TEMPORARY DEVELOPMENT BYPASS
      // Login/Register is skipped while the group is developing.
      // Restore: home: const LoginScreen(),
      home: const HomeScreen(),
    );
  }
}
