import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper();

  // USER
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final goalController = TextEditingController();

  // WORKOUT
  final workoutName = TextEditingController();
  final workoutDesc = TextEditingController();
  final duration = TextEditingController();
  final calories = TextEditingController();

  // DIET
  final mealName = TextEditingController();
  final mealCalories = TextEditingController();
  final protein = TextEditingController();
  final carbs = TextEditingController();
  final fat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fitness Tracker")),
      body: Container(width: 400, height: 400, color: Colors.grey),
    );
  }
}
/*

SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// USER SECTION
            Text(
              "User Info",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: "Weight"),
            ),
            TextField(
              controller: goalController,
              decoration: InputDecoration(labelText: "Fitness Goal"),
            ),

            ElevatedButton(
              onPressed: () async {
                await db.insertUser({
                  "name": nameController.text,
                  "age": int.parse(ageController.text),
                  "weight": double.parse(weightController.text),
                  "fitnessGoal": goalController.text,
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("User Saved")));
              },
              child: Text("Save User"),
            ),

            SizedBox(height: 30),

            /// WORKOUT SECTION
            Text(
              "Workout",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: workoutName,
              decoration: InputDecoration(labelText: "Workout Name"),
            ),
            TextField(
              controller: workoutDesc,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: duration,
              decoration: InputDecoration(labelText: "Duration"),
            ),
            TextField(
              controller: calories,
              decoration: InputDecoration(labelText: "Calories Burned"),
            ),

            ElevatedButton(
              onPressed: () async {
                await db.insertWorkout({
                  "name": workoutName.text,
                  "description": workoutDesc.text,
                  "duration": int.parse(duration.text),
                  "calories": int.parse(calories.text),
                  "completed": 1,
                  "date": DateTime.now().toString(),
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Workout Saved")));
              },
              child: Text("Save Workout"),
            ),

            SizedBox(height: 30),

            /// DIET SECTION
            Text(
              "Diet",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: mealName,
              decoration: InputDecoration(labelText: "Meal Name"),
            ),
            TextField(
              controller: mealCalories,
              decoration: InputDecoration(labelText: "Calories"),
            ),
            TextField(
              controller: protein,
              decoration: InputDecoration(labelText: "Protein"),
            ),
            TextField(
              controller: carbs,
              decoration: InputDecoration(labelText: "Carbs"),
            ),
            TextField(
              controller: fat,
              decoration: InputDecoration(labelText: "Fat"),
            ),

            ElevatedButton(
              onPressed: () async {
                await db.insertDiet({
                  "mealName": mealName.text,
                  "calories": int.parse(mealCalories.text),
                  "protein": int.parse(protein.text),
                  "carbs": int.parse(carbs.text),
                  "fat": int.parse(fat.text),
                  "date": DateTime.now().toString(),
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Diet Saved")));
              },
              child: Text("Save Diet"),
            ),
          ],
        ),
      ),
);*/