import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase before using Firebase services
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ceylon Heritage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F2EB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A2B),
          primary: const Color(0xFF1E3A2B),
          secondary: const Color(0xFFC88E38),
          surface: const Color(0xFFF7F2EB),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
