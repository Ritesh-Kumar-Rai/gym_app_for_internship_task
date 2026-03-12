import 'package:bilixis_gym_app/fitness_app_version2/database/database_helper.dart';
import 'package:flutter/material.dart';

class FitnessHomePage extends StatefulWidget {
  @override
  State<FitnessHomePage> createState() => _FitnessHomePageState();
}

class _FitnessHomePageState extends State<FitnessHomePage> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // --- Header Section ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?u=anna',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const Text(
                            'Anna Santos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // --- Today's Workout Summary Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Workout Progress',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '14 Exercise Left',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            value: 0.6,
                            strokeWidth: 6,
                            backgroundColor: Colors.grey[800],
                            color: const Color(0xFF7B61FF),
                          ),
                        ),
                        const Text(
                          '60%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- Horizontal Metric Cards (Steps, Water, etc.) ---
              const SectionHeader(title: "Health Overview"),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    const MetricCard(
                      title: "Calories Burnt",
                      value: "1.4k",
                      unit: "kCal",
                      icon: "🔥",
                      color: Colors.orange,
                    ),
                    const MetricCard(
                      title: "Distance Covered",
                      value: "3.8",
                      unit: "km",
                      icon: "🏃",
                      color: Colors.blue,
                    ),
                    const MetricCard(
                      title: "Water Intake",
                      value: "2.5",
                      unit: "Liters",
                      icon: "💧",
                      color: Colors.cyan,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- Popular Exercise Section ---
              const SectionHeader(title: "Popular Exercise"),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5D9FF),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Squat Low,\nBuild Strength',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '24 Exercise',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF121212),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Start Now'),
                          ),
                        ],
                      ),
                    ),
                    // In a real app, replace with a local Image.asset
                    const Icon(
                      Icons.fitness_center,
                      size: 100,
                      color: Colors.black12,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Card 1: Yoga
              ExerciseCard(
                title: "Morning Flow:\nFlexibility",
                count: "12 Exercises",
                color: const Color(0xFFE0F2F1),
                icon: Icons.self_improvement,
              ),
              const SizedBox(height: 30),
              // Card 2: HIIT
              ExerciseCard(
                title: "Fat Blast:\nHIIT Cardio",
                count: "18 Exercises",
                color: const Color(0xFFF3E0),
                icon: Icons.bolt,
              ),
              const SizedBox(height: 30),
              // Card 3: Upper Body
              ExerciseCard(
                title: "Upper Body:\nPush Day",
                count: "10 Exercises",
                color: const Color(0xFFFFEBEE),
                icon: Icons.fitness_center,
              ),
              const SizedBox(height: 30),
              // Card 4: Running
              ExerciseCard(
                title: "Endurance:\n5km Prep",
                count: "6 Sessions",
                color: const Color(0xFFE3F2FD),
                icon: Icons.directions_run,
              ),
              const SizedBox(height: 30),
              // Card 5: Pilates
              ExerciseCard(
                title: "Core Power:\nPilates Pro",
                count: "15 Exercises",
                color: const Color(0xFFF3E5F5),
                icon: Icons.accessibility_new,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTabController(
                  length: 3,
                  child: SizedBox(
                    height: 700,
                    child: Column(
                      children: [
                        // 1️⃣ Tab bar
                        TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blue,
                          tabs: const [
                            Tab(text: "Log Workout"),
                            Tab(text: "Log Diet"),
                            Tab(text: "Log User"),
                          ],
                        ),
                        // 2️⃣ Tab content
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Tab 1 content
                              WorkoutForm(context),
                              // Tab 2 content
                              DietForm(context),
                              // Tab 3 content
                              Center(child: Text("Content for Tab 3")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // custom widgets
  Widget WorkoutForm(BuildContext context) {
    return Column(
      children: [
        /// WORKOUT SECTION
        SizedBox(height: 20),
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
        SizedBox(height: 20),

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
      ],
    );
  }

  Widget DietForm(BuildContext context) {
    return Column(
      children: [
        /// DIET SECTION
        SizedBox(height: 20),
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
        SizedBox(height: 20),
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
    );
  }
}

// --- Reusable Components ---

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'See Details',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title, value, unit, icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(icon, style: const TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Exercise card
class ExerciseCard extends StatelessWidget {
  final String title, count;
  final Color color;
  final IconData icon;

  const ExerciseCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(count, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF121212),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Start Now'),
                ),
              ],
            ),
          ),
          Icon(icon, size: 80, color: Colors.black12),
        ],
      ),
    );
  }
}
