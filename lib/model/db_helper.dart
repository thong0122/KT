import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ktdgkt/model/task.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'db_task.db');
    print("Đường dẫn database: $path");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print("Creating database tables...");
    await db.execute('''
      CREATE TABLE task(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        day TEXT, 
        content TEXT, 
        time TEXT, 
        locate TEXT, 
        preside TEXT, 
        note TEXT
      )
    ''');
  }

  Future<void> _deleteDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'db_task.db');
    await deleteDatabase(dbPath);
    _database = null; // Reset the instance variable
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  Future<void> recreateTables() async {
    await _deleteDatabase();
    _database = await _initDatabase();
  }

  // CRUD dành cho Task
  Future<void> insertTask(TaskModel taskModel) async {
    final db = await _databaseService.database;
    await db.insert(
      'task',
      taskModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskModel>> tasks() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('task');
    return List.generate(
        maps.length, (index) => TaskModel.fromMap(maps[index]));
  }

  Future<TaskModel> task(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('task', where: 'id = ?', whereArgs: [id]);
    return TaskModel.fromMap(maps[0]);
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await _databaseService.database;
    await db.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}