import 'dart:convert';
import 'dart:io'; // SocketException ke liye
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';

class ApiService {
  static const String url =
      "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken";

  Future<List<Meal>> fetchMeals() async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(
            const Duration(seconds: 10), // 10 seconds timeout
          );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        // Agar API response null aaye (No data found)
        if (data['meals'] == null) {
          throw Exception('No meals found for this search.');
        }

        List<dynamic> mealsJson = data['meals'];
        return mealsJson.map((json) => Meal.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('Server Error: Resource not found (404)');
      } else if (response.statusCode >= 500) {
        throw Exception('Server is down. Please try again later (500)');
      } else {
        throw Exception(
          'Something went wrong. Status Code: ${response.statusCode}',
        );
      }
    } on SocketException {
      // Jab internet na ho
      throw Exception('No Internet connection. Please check your network.');
    } on http.ClientException {
      // Jab request client side se fail ho
      throw Exception('Client Exception: Could not connect to the server.');
    } on FormatException {
      // Jab JSON parsing mein galti ho
      throw Exception('Bad response format from server.');
    } catch (e) {
      // Koi bhi aur random error
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
