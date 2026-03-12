class Workout {
  final String name;
  final int duration; // minutes
  final int calories;
  final DateTime date;

  Workout({
    required this.name,
    required this.duration,
    required this.calories,
    required this.date,
  });
}

class WaterLog {
  final int amount; // ml
  final DateTime date;

  WaterLog({required this.amount, required this.date});
}

class StepLog {
  final int steps;
  final DateTime date;

  StepLog({required this.steps, required this.date});
}
