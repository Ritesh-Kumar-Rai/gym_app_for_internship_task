import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveProfile(
    String name,
    String age,
    String weight,
    String goal,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('age', age);
    await prefs.setString('weight', weight);
    await prefs.setString('goal', goal);
  }

  Future<Map<String, String>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? 'Guest',
      'age': prefs.getString('age') ?? '25',
      'weight': prefs.getString('weight') ?? '70',
      'goal': prefs.getString('goal') ?? 'Fitness',
    };
  }
}
