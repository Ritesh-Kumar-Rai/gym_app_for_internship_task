import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/main_wrapper.dart';
import "../../fitness_app_version2/screens/fitness_main_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 seconds ka timer: uske baad Dashboard par bhej dega
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => const MainWrapper()),
        MaterialPageRoute(builder: (context) => FitnessApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Creative Gradient Background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Colors.black],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gym Icon (Creative Logo placeholder)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFCCFF00), width: 2),
              ),
              child: const Icon(
                Icons.fitness_center,
                size: 80,
                color: Color(0xFFCCFF00), // Neon Green
              ),
            ),
            const SizedBox(height: 20),
            // App Name with Creative Font Style
            const Text(
              "GYM PRO",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "NO PAIN, NO GAIN",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFCCFF00),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 50),
            // Chota sa loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCCFF00)),
            ),
          ],
        ),
      ),
    );
  }
}
