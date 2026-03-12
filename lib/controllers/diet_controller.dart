import 'package:bilixis_gym_app/models/meal_model.dart';
import 'package:bilixis_gym_app/services/api_service.dart';

class DietController {
  final ApiService _apiService = ApiService();

  late Future<List<Meal>> mealsFuture;

  void loadMeals() {
    mealsFuture = _apiService.fetchMeals();
  }

  void retry() {
    mealsFuture = _apiService.fetchMeals();
  }
}
