import 'package:bilixis_gym_app/fitness_app_version2/screens/diet_screen.dart';
import 'package:bilixis_gym_app/fitness_app_version2/screens/home_screen2.dart';
import 'package:flutter/material.dart';
// import 'package:learning_flutter/fitness/screens/notification_screen.dart';
// import 'home_screen.dart';
import 'history_screen.dart';

class FitnessApp extends StatefulWidget {
  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  int currentIndex = 0;

  final screens = [
    // HomeScreen(),
    FitnessHomePage(),
    FoodHomePage(),
    // NotificationScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined),
              label: "Diet",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notification_add),
            //   label: "Notifications",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
          ],

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
