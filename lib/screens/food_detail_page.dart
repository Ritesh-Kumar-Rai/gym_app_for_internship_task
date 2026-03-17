import 'package:bilixis_gym_app/models/recipe_ds.dart';
import 'package:flutter/material.dart';

class FoodDetailPage extends StatefulWidget {
  // Receive the food data passed from the home screen
  final Map<String, dynamic> foodItem;

  const FoodDetailPage({super.key, required this.foodItem});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1; // Basic quantity state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. The Hero Image Section
                Hero(
                  tag: widget
                      .foodItem['heroTag'], // Must match the source unique tag
                  child: Container(
                    height: 380,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(
                        0xFFFFEAEF,
                      ), // Soft pink background matching image_4.png placeholder
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 120,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                // 2. Info Section
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Quantity Selector Row
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.foodItem['title'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 5,
                          children: [
                            FoodNutrientsCard(
                              title: "🔥 Calories",
                              points: 350,
                              type: "kcal",
                            ),
                            FoodNutrientsCard(
                              title: "🍀 Carbs",
                              points: 42.2,
                              type: 'g',
                            ),
                            FoodNutrientsCard(
                              title: "🍌 Fat",
                              points: 19.3,
                              type: 'g',
                            ),
                            FoodNutrientsCard(
                              title: "🥞 Protein",
                              points: 3.5,
                              type: 'g',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // --- Description ---
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.grey, height: 1.6),
                          children: [
                            TextSpan(
                              text:
                                  "Originating from Cyprus, semisoft and slightly nutty halloumi cheese resists melting when heated, so you can luxuriate",
                            ),
                            TextSpan(
                              text: " Read More...",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // --- Map Placeholder Container ---
                      const Text(
                        "Recipe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Container(
                      //   height: 750,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white24,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.vertical,
                      //     itemCount: pizzaNapoletanaSteps.length,
                      //     itemBuilder: (context, index) {
                      //       final step = pizzaNapoletanaSteps[index];

                      //       return ListTile(
                      //         leading: CircleAvatar(
                      //           child: Text(step.stepNumber.toString()),
                      //         ),
                      //         title: Text(
                      //           step.title,
                      //           style: TextStyle(fontWeight: FontWeight.bold),
                      //         ),
                      //         subtitle: Text(
                      //           step.description,
                      //           style: TextStyle(
                      //             color: Colors.black54,
                      //             fontSize: 13,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      ...pizzaNapoletanaSteps.map((step) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(step.stepNumber.toString()),
                          ),
                          title: Text(
                            step.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            step.description,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        );
                      }),

                      // Space for the floating bottom navigation bar
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Floating Custom App Bar (Back and Cart buttons)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  CircleButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Cart Button
                  const CircleButton(
                    icon: Icons.favorite_rounded,
                    badgeCount: 2,
                    colors: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// REUSABLE UI COMPONENTS FOR DETAIL PAGE
// -------------------------------------------------------------

// Simple Icon with label used for distance/ratings
class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: (icon == Icons.star) ? Colors.amber : const Color(0xFFFFAB91),
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}

// Circle buttons with optional badge used in the floating header
class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final int badgeCount;
  final Color colors;

  const CircleButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.badgeCount = 0,
    this.colors = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: colors),
          ),
          if (badgeCount > 0)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFAB91),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$badgeCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget FoodNutrientsCard({
  required String title,
  required double points,
  required String type,
}) {
  return Container(
    width: 100,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          spacing: 2,
          children: [
            Text(
              points.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(type, style: TextStyle(fontSize: 10)),
          ],
        ),
      ],
    ),
  );
}
