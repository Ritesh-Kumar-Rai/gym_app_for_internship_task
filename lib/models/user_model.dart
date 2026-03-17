class User {
  String name;
  int age;
  double weight;
  String fitnessGoal;

  User({
    required this.name,
    required this.age,
    required this.weight,
    required this.fitnessGoal,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'fitnessGoal': fitnessGoal,
    };
  }
}
