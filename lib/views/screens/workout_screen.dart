import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  // Dummy data for workouts [cite: 37]
  final List<Map<String, String>> workouts = const [
    {
      "title": "Chest & Triceps",
      "subtitle": "12 Exercises",
      "duration": "45 min",
      "level": "Intermediate",
    },
    {
      "title": "Leg Day (Squats Focus)",
      "subtitle": "8 Exercises",
      "duration": "60 min",
      "level": "Advanced",
    },
    {
      "title": "Full Body Cardio",
      "subtitle": "10 Exercises",
      "duration": "30 min",
      "level": "Beginner",
    },
    {
      "title": "Back & Biceps",
      "subtitle": "11 Exercises",
      "duration": "50 min",
      "level": "Intermediate",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Workouts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A), // Dark Card [cite: 44]
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                // Icon/Image Placeholder
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFF00).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: Color(0xFFCCFF00),
                  ),
                ),
                const SizedBox(width: 16),
                // Workout Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        workout['subtitle']!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Color(0xFFCCFF00),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            workout['duration']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.bolt,
                            color: Colors.orange,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            workout['level']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white24,
                  size: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
