import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), 'fitness.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
  CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER,
    weight REAL,
    fitnessGoal TEXT
  )
  ''');

        await db.execute('''
        CREATE TABLE workouts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          duration INTEGER,
          calories INTEGER,
          completed INTEGER,
          date TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE diet(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          mealName TEXT,
          calories INTEGER,
          protein INTEGER,
          carbs INTEGER,
          fat INTEGER,
          date TEXT
        )
        ''');
      },
    );
  }

  Future<void> getDbPath() async {
    String path = join(await getDatabasesPath(), 'fitness.db');
    print("database path: $path");
  }

  /// INSERT USER
  Future<int> insertUser(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("user", data);
  }

  /// INSERT WORKOUT
  Future<int> insertWorkout(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("workouts", data);
  }

  /// INSERT DIET
  Future<int> insertDiet(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("diet", data);
  }

  /// GET WORKOUT HISTORY
  Future<List<Map<String, dynamic>>> getWorkouts() async {
    final db = await database;
    return await db.query("workouts", orderBy: "date DESC");
  }

  /// GET DIET HISTORY
  Future<List<Map<String, dynamic>>> getDiet() async {
    final db = await database;
    return await db.query("diet", orderBy: "date DESC");
  }
}
