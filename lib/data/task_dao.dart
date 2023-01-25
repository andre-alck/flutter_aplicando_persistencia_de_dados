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

  Map<String, dynamic> toMap(Task task) {
    return {
      'name': task.name,
      'imageUrl': task.imageUrl,
      'difficulty': task.difficulty
    };
  }

  Future<int> save(Task task) async {
    debugPrint('save');

    final Database database = await getDatabase();
    List<Task> tasks = await find(task.name);
    bool taskExists = tasks.isEmpty;
    late final int numberOfChanges;

    if (taskExists) {
      numberOfChanges = await database.insert(_tableName, toMap(task));
    } else {
      numberOfChanges = await database.update(_tableName, toMap(task),
          where: '$_name = ?', whereArgs: [task.name]);
    }

    return numberOfChanges;
  }

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

  Future<int> update(Task task) async {
    debugPrint('update');

    List<Task> tasks = await find(task.name);
    bool taskExists = tasks.isNotEmpty;

    int numberOfChanges = 0;
    if (taskExists) {
      final Database database = await getDatabase();
      numberOfChanges = await database.update(_tableName, toMap(task),
          where: '$_name = ?', whereArgs: [task.name]);
    }

    return numberOfChanges;
  }

  Future<int> delete(String taskName) async {
    debugPrint('delete');

    List<Task> tasks = await find(taskName);
    bool taskExists = tasks.isNotEmpty;

    int numberOfChanges = 0;
    if (taskExists) {
      final Database database = await getDatabase();
      numberOfChanges = await database
          .delete(_tableName, where: '$_name = ?', whereArgs: [taskName]);
    }

    return numberOfChanges;
  }
}
