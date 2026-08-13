import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const SplashScreen(),
    );
  }
}
