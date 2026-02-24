import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_model.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({super.key});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Meal>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = _apiService.fetchMeals(); // API call on start [cite: 54]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Healthy Diet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Meal>>(
        future: _mealsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFCCFF00)),
            );
          } else if (snapshot.hasError) {
            // Gracefully handle and display the error message
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      snapshot.error.toString().replaceFirst('Exception: ', ''),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _mealsFuture = _apiService.fetchMeals(); // Retry logic
                      }),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No meals found"));
          }

          final meals = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Card(
                color: const Color(0xFF1A1A1A),
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      meal.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    meal.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    meal.category,
                    style: const TextStyle(color: Color(0xFFCCFF00)),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white24,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
