class Diet {
  int? id;
  String mealName;
  int calories;
  int protein;
  int carbs;
  int fat;
  String date;

  Diet({
    this.id,
    required this.mealName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mealName': mealName,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'date': date,
    };
  }

  factory Diet.fromMap(Map<String, dynamic> map) {
    return Diet(
      id: map['id'],
      mealName: map['mealName'],
      calories: map['calories'],
      protein: map['protein'],
      carbs: map['carbs'],
      fat: map['fat'],
      date: map['date'],
    );
  }
}
