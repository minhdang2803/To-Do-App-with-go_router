import 'package:flutter/material.dart';
import 'package:todoapp/database_helper.dart';
import 'package:todoapp/models/models.dart';
import 'package:todoapp/theme.dart';

class TaskManager extends ChangeNotifier {
  final _database = DatabaseHelper.instance;
  static const _taskTable = 'Tasks';
  Future<void> addTask(Task task) async {
    await _database.insertTask(task);
    notifyListeners();
  }

  ChipSelection _selection = ChipSelection.normal;
  String _description = '';
  String _title = '';
  String _contentInside = '';
  Color _color = TodoThemeManager.normalChipColor;

  ChipSelection get getSelection => _selection;
  Color get getColor => _color;
  String get getTitle => _title;
  String get getDescription => _description;
  String get getContentInside => _contentInside;
  void setDefault() {
    _selection = ChipSelection.normal;
    _color = TodoThemeManager.normalChipColor;
  }

  void setTask(Task task) {
    _title = task.title!;
    _description = task.description!;
    _contentInside = task.contextInside!;
    if (task.chipLabel == 'Normal') {
      _selection = ChipSelection.normal;
      _color = TodoThemeManager.normalChipColor;
    } else if (task.chipLabel == 'Important') {
      _selection = ChipSelection.important;
      _color = TodoThemeManager.importantChipColor;
    } else {
      _selection = ChipSelection.urgent;
      _color = TodoThemeManager.veryImportantChipCplor;
    }
  }

  void setSelection(ChipSelection selection) {
    _selection = selection;
    notifyListeners();
  }

  String getPriority(ChipSelection chip) {
    if (chip == ChipSelection.normal) {
      return 'Normal';
    } else if (chip == ChipSelection.important) {
      return 'Important';
    } else {
      return 'Urgent';
    }
  }

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  Future<List<Task>> getTaskList() async {
    final db = await _database.database;
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

  Future<int> deleteCurrentTask(Task task) async {
    final db = await _database.database;
    final result = await db.rawDelete('''
    DELETE FROM $_taskTable WHERE $_taskTable.title = '${task.title}'
''');
    notifyListeners();
    return result;
  }

  Future<void> deleteAllTask() async {
    final db = await _database.database;
    await db.delete(_taskTable);
    notifyListeners();
  }

  Future<int> setDescription(String description, String title) async {
    final db = await _database.database;
    final result = await db.rawUpdate('''
  UPDATE $_taskTable
  SET description = "$description"
  WHERE $_taskTable.title = '$title'
''');
    notifyListeners();
    return result;
  }

  Future<int> setTitle(String title, String taskTitle) async {
    final db = await _database.database;
    final result = await db.rawUpdate('''
  UPDATE $_taskTable
  SET title = "$title"
  WHERE $_taskTable.title = '$taskTitle'
  ''');
    notifyListeners();
    return result;
  }

  Future<int> setPriority(String taskTitle) async {
    final db = await _database.database;
    final result = await db.rawUpdate('''
  UPDATE $_taskTable
  SET backgroundColor = ${_color.value}, chipLabel = '${getPriority(_selection)}'
  WHERE title = '$taskTitle'
''');
    notifyListeners();
    return result;
  }

  Future<int> changeContent(String content) async {
    final db = await _database.database;
    final result = await db.rawUpdate('''
  UPDATE $_taskTable
  SET contextInside = '$content'
  WHERE title = '$_title'
''');
    notifyListeners();
    return result;
  }
}
