import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './widgets/splash_screen.dart';

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Pro',
      theme: ThemeData(
        brightness: Brightness.dark, // for dark theme
        primaryColor: const Color(0xFFCCFF00), // Neon Green color
        scaffoldBackgroundColor: Colors.black, // Background pure black
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home:
          const SplashScreen(), // At first this screen appeared then after some delay it will redirect to home/summary page
    );
  }
}
