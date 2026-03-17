import 'package:flutter/material.dart';
import 'food_detail_page.dart'; // Import the second screen

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Teal Header Background
          Container(
            height: 250,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE5D9FF),
                  Color(0xFF00BFA5),
                  Color(0xFFE5D9FF),
                ],
              ),
            ),
          ),

          // 2. Content that sits on top of/scrolls over the background
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // --- custom header widget ---
                  const FoodAppHeader(),
                  const SizedBox(height: 25),

                  // --- Main Body (White Rounded Container) ---
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- "Recommended" Section ---
                        const SectionHeader(title: "Recomended"),
                        const SizedBox(height: 15),
                        const RecommendedFoodScroll(),
                        const SizedBox(height: 25),

                        // --- "Near you" Section ---
                        const SectionHeader(title: "Explore Foods"),
                        const SizedBox(height: 15),
                        const NearYouFoodScroll(),
                        // Add some bottom padding
                        const SizedBox(height: 30),
                      ],
                    ),
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
// REUSABLE UI COMPONENTS FOR HOME PAGE
// -------------------------------------------------------------

// 1. The custom header with title, search, and icon
class FoodAppHeader extends StatelessWidget {
  const FoodAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Delicious food ready to\ndelivered for you",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("🍜", style: const TextStyle(fontSize: 20)),
                ],
              ),
              // Profile or notification icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // --- Center Search Bar ---
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search food would you like to eat",
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Simple header for sections (Recommended, Near You)
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
          style: const TextStyle(
            color: Color(0xFF1A1D26),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("See All", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

// 3. Horizontal Scroll for Recommended Food (HERO TRIGGER)
class RecommendedFoodScroll extends StatelessWidget {
  const RecommendedFoodScroll({super.key});

  @override
  Widget build(BuildContext context) {
    // List of data (representing what's in image_3.png)
    final List<Map<String, dynamic>> recommendedItems = [
      {
        'id': 'rec_1',
        'title': 'Grilled Cheese Salad ...',
        'price': '\$15.50',
        'rating': '4.7',
        // In a real app, use different colors/assets per item
        'heroTag': 'salad_hero',
      },
      {
        'id': 'rec_2',
        'title': 'Pizza Napoletana',
        'price': '\$12.40',
        'rating': '4.5',
        'heroTag': 'pizza_hero',
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: recommendedItems.length,
        itemBuilder: (context, index) {
          final item = recommendedItems[index];

          // Wrap the specific card in a GestureDetector for navigation
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(
                    foodItem: item, // Pass the selected item data
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- The Hero Animated Image ---
                  Hero(
                    tag: item['heroTag'], // MUST BE UNIQUE
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Placeholder image area
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Use Stack to overlay the rating
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.fastfood,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    item['rating'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['price'],
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 4. Horizontal Scroll for Near You (Slightly different card style)
class NearYouFoodScroll extends StatelessWidget {
  const NearYouFoodScroll({super.key});

  @override
  Widget build(BuildContext context) {
    // List of data (representing what's in image_3.png bottom)
    final List<Map<String, dynamic>> nearYouItems = [
      {
        'title': 'Paneer Salad',
        'restaurant': 'Gaminbar',
        'distance': '9.2 Km',
        'price': '\$4.2',
        'rating': '4.4',
      },
      {
        'title': 'Sushi Platter',
        'restaurant': 'Tokyo Taste',
        'distance': '1.5 Km',
        'price': '\$18.0',
        'rating': '4.9',
      },
    ];

    return SizedBox(
      height: 120, // Shorter container height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: nearYouItems.length,
        itemBuilder: (context, index) {
          final item = nearYouItems[index];

          return Container(
            width: 320, // Wide card
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[100]!),
            ),
            child: Row(
              children: [
                // 1. Food Image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(Icons.restaurant, size: 40, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 15),

                // 2. Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${item['restaurant']} • ${item['distance']}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 3),
                          Text(
                            item['rating'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 3. Price
                Text(
                  item['price'],
                  style: const TextStyle(
                    color: Color(0xFF00C7C7),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
