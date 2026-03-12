import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. WELCOME HEADER
              const Text(
                "Welcome Back, Champ! 🔥",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Keep pushing your limits.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),

              // 2. PROGRESS CARD [cite: 33]
              _buildProgressCard(),
              const SizedBox(height: 25),

              // 3. TODAY'S WORKOUT SUMMARY [cite: 32]
              const Text(
                "Today's Workout Summary",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // Responsive Grid for Stats [cite: 73]
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatTile(
                        "Calories",
                        "450 kcal",
                        Icons.local_fire_department,
                        Colors.orange,
                      ),
                      _buildStatTile(
                        "Workouts",
                        "1.5 hrs",
                        Icons.timer,
                        Colors.blue,
                      ),
                      _buildStatTile(
                        "Steps",
                        "8,500",
                        Icons.directions_walk,
                        Colors.green,
                      ),
                      _buildStatTile(
                        "Water",
                        "2.5 L",
                        Icons.water_drop,
                        Colors.lightBlue,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 25),

              // 4. QUICK ACTIONS [cite: 34]
              const Text(
                "Quick Actions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                    "Log Workout",
                    Icons.add,
                    Color(0xFFCCFF00), // neonGreen color
                  ),
                  _buildActionButton(
                    "Track Diet",
                    Icons.restaurant,
                    Colors.orangeAccent,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          "Walk 10 minutes",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "30Kcal",
                          style: TextStyle(color: Colors.grey),
                        ),
                        leading: Icon(Icons.directions_walk),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Walk 10 minutes",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "30Kcal",
                          style: TextStyle(color: Colors.grey),
                        ),
                        leading: Icon(Icons.directions_walk),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI HELPER WIDGETS ---

  // Widget _buildProgressCard() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         colors: [Color(0xFFCCFF00), Color(0xFF99CC00)],
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: const Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Weekly Goal",
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 5),
  //             Text(
  //               "75% Completed",
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             LinearProgressIndicator(value: 0.6), // value is null by default
  //           ],
  //         ),
  //         Icon(Icons.insights, size: 40, color: Colors.black),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFCCFF00), Color(0xFF99CC00)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// FIX: Expanded added
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Weekly Goal",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "75% Completed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                LinearProgressIndicator(
                  value: 0.75,
                  backgroundColor: Colors.white54,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          const Icon(Icons.insights, size: 40, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildStatTile(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
