import 'dart:math';

import 'package:bilixis_gym_app/database/database_helper.dart';
import 'package:bilixis_gym_app/widgets/premium_hydration_card.dart';
import 'package:flutter/material.dart';

class WaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);

    path.quadraticBezierTo(
      0,
      size.height * 0.35,
      size.width * 0.2,
      size.height,
    );

    path.lineTo(size.width * 0.8, size.height);

    path.quadraticBezierTo(size.width, size.height * 0.35, size.width / 2, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WavePainter extends CustomPainter {
  final double animation;
  final double level;

  WavePainter(this.animation, this.level);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backWave = Paint()..color = Colors.blue.withOpacity(0.35);
    Paint frontWave = Paint()..color = Colors.blue;

    double baseHeight = size.height * level;

    Path path1 = Path();
    Path path2 = Path();

    path1.moveTo(0, baseHeight);
    path2.moveTo(0, baseHeight);

    for (double i = 0; i <= size.width; i++) {
      path1.lineTo(
        i,
        baseHeight + 10 * sin((i / size.width * 2 * pi) + animation * 2 * pi),
      );

      path2.lineTo(
        i,
        baseHeight +
            15 * sin((i / size.width * 2 * pi) + animation * 2 * pi + pi / 2),
      );
    }

    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);

    canvas.drawPath(path1, backWave);
    canvas.drawPath(path2, frontWave);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// custom widget for water level animation
class WaterDropWidget extends StatefulWidget {
  final double waterLevel;

  const WaterDropWidget({required this.waterLevel});

  @override
  _WaterDropWidgetState createState() => _WaterDropWidgetState();
}

class _WaterDropWidgetState extends State<WaterDropWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: ClipPath(
        clipper: WaterDropClipper(),
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return CustomPaint(
              painter: WavePainter(controller.value, widget.waterLevel),
            );
          },
        ),
      ),
    );
  }
}

// 2nd

class WaterBowl extends StatefulWidget {
  final double waterLevel;

  const WaterBowl({super.key, required this.waterLevel});

  @override
  State<WaterBowl> createState() => _WaterBowlState();
}

class _WaterBowlState extends State<WaterBowl>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double animatedLevel = 0.6;

  @override
  void initState() {
    super.initState();

    animatedLevel = widget.waterLevel;

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant WaterBowl oldWidget) {
    super.didUpdateWidget(oldWidget);

    // smooth water level animation
    setState(() {
      animatedLevel = widget.waterLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: animatedLevel, end: widget.waterLevel),
      duration: const Duration(milliseconds: 800),
      builder: (context, level, child) {
        return SizedBox(
          width: 260,
          height: 160,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(130),
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, __) {
                return CustomPaint(
                  painter: WavePainter(controller.value, level),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// ------------------------------------------------
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

  // water level states
  double waterLevel = 0.7;

  void addWater() {
    setState(() {
      waterLevel -= 0.05; // water rises
      if (waterLevel < 0.1) waterLevel = 0.1;
    });
  }

  void removeWater() {
    setState(() {
      waterLevel += 0.08;
      if (waterLevel > 0.9) waterLevel = 0.9;
    });
  }

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
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFqxrMeDw9jIUKRVipzMxGy8nHpRhpancrmQ&s',
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

              // Quick Logging
              const SectionHeader(title: "Quick Log"),
              const SizedBox(height: 16),

              // Container(
              //   height: 400,
              //   width: double.infinity,
              //   padding: EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFE0F2F1),
              //     borderRadius: BorderRadius.circular(28),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Today's Water Consumed 💧",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),
              //       ),
              //       Row(
              //         children: [
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Center(
              //                 // child: WaterDropWidget(waterLevel: waterLevel),
              //                 // child: WaterBowl(waterLevel: waterLevel),
              //                 child: HydrationCard(),
              //               ),
              //               // SizedBox(height: 30),

              //               // ElevatedButton(
              //               //   onPressed: addWater,
              //               //   child: Icon(Icons.add),
              //               // ),
              //               // ElevatedButton(
              //               //   onPressed: removeWater,
              //               //   child: Icon(Icons.exposure_minus_1),
              //               // ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Center(child: HydrationCardPremium()),
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
