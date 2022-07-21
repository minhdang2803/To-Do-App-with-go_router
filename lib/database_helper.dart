import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/models.dart';

class DatabaseHelper {
  static const _databaseName = 'todo_database.db';
  static const _databaseVersion = 1;
  static const _taskTable = 'Tasks';
  static Database? _database;

  // Singleton Pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_taskTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          chipLabel TEXT, 
          backgroundColor INTEGER, 
          title TEXT, 
          description TEXT, 
          contextInside TEXT 
        );''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return await db.insert(
      _taskTable,
      task.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTask() async {
    final db = await instance.database;
    final tasks = await db.query(_taskTable, columns: [
      'id',
      'chipLabel',
      'backgroundColor',
      'title',
      'description',
      'contextInside',
    ]);
    List<Task> ret = tasks.isNotEmpty
        ? tasks.map((task) => Task.fromJSON(task)).toList()
        : [];
    return ret;
  }

  // Future<int> selectTask() async{}
}
