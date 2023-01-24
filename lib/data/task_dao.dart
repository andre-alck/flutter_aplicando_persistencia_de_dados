import 'package:flutter/cupertino.dart';
import 'package:flutter_aplicando_persistencia_de_dados/components/task.dart';
import 'package:flutter_aplicando_persistencia_de_dados/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String createQuery =
      '''CREATE TABLE $_tableName('$_name TEXT', '$_imageUrl TEXT', '$_difficulty INTEGER')''';

  static const String _tableName = 'task';
  static const String _name = 'name';
  static const String _imageUrl = 'imageUrl';
  static const String _difficulty = 'difficulty';

  List<Task> toList(List<Map<String, dynamic>> mapList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> map in mapList) {
      tasks.add(Task(map[_name], map[_difficulty], map[_difficulty]));
    }

    return tasks;
  }

  void save() async {}
  Future<List<Task>> findAll() async {
    debugPrint('findAll');
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> taskList =
        await database.query(_tableName);
    return toList(taskList);
  }

  Future<List<Task>> find(String taskName) async {
    debugPrint('find');
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> tasks = await database
        .query(_tableName, where: '$_name = ?', whereArgs: [taskName]);
    return toList(tasks);
  }

  Future<Task> update(String taskName) async {}
  void delete(String taskName) async {}
}
