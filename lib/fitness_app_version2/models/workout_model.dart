class Workout {
  int? id;
  String name;
  String description;
  int duration;
  int calories;
  int completed;
  String date;

  Workout({
    this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.calories,
    required this.completed,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'calories': calories,
      'completed': completed,
      'date': date,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      duration: map['duration'],
      calories: map['calories'],
      completed: map['completed'],
      date: map['date'],
    );
  }
}
