class Meal {
  final String name;
  final String imageUrl;
  final String category;

  Meal({required this.name, required this.imageUrl, required this.category});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
      category: json['strCategory'] ?? 'Healthy',
    );
  }
}
