import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vocabkpop/models/LessonModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'lesson.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE lesson(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, idMember TEXT)",
        );
      },
    );
  }

  Future<void> insertLesson(LessonModel lesson) async {
    final db = await database;
    await db.insert(
      'lesson',
      lesson.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LessonModel>> getLessons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('lesson');

    return List.generate(maps.length, (i) {
      return LessonModel.fromMap(maps[i]);
    });
  }
}
