import 'package:flutter/material.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/models/database_model.dart';
import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/widgets/task_widget.dart';

class TaskDao {
  static const String createQuery =
      '''CREATE TABLE $_tableName (name TEXT, difficulty INTEGER, imageUrl TEXT)''';

  static const String _tableName = 'task';
  static const String _name = 'name';
  static const String _imageUrl = 'imageUrl';
  static const String _difficulty = 'difficulty';

  List<Task> toList(List<Map<String, dynamic>> mapList) {
    final tasks = <Task>[];
    for (final map in mapList) {
      final name = map[_name];
      final imageUrl = map[_imageUrl];
      final difficulty = map[_difficulty];
      final task = Task(name, imageUrl, difficulty);

      tasks.add(task);
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

    final databaseModel = DatabaseModel();

    final database = await databaseModel.getDatabase();
    final tasks = await find(task.name);
    final taskDoesNotExist = tasks.isEmpty;
    late final int numberOfChanges;

    if (taskDoesNotExist) {
      numberOfChanges = await database.insert(_tableName, toMap(task));
    } else {
      numberOfChanges = await database.update(
        _tableName,
        toMap(task),
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }

    return numberOfChanges;
  }

  Future<List<Task>> findAll() async {
    debugPrint('findAll');

    final databaseModel = DatabaseModel();
    final database = await databaseModel.getDatabase();
    final List<Map<String, dynamic>> taskList =
        await database.query(_tableName);
    return toList(taskList);
  }

  Future<List<Task>> find(String taskName) async {
    debugPrint('find');

    final databaseModel = DatabaseModel();
    final database = await databaseModel.getDatabase();
    final List<Map<String, dynamic>> tasks = await database
        .query(_tableName, where: '$_name = ?', whereArgs: [taskName]);
    return toList(tasks);
  }

  Future<int> update(Task task) async {
    debugPrint('update');

    final tasks = await find(task.name);
    final taskExists = tasks.isNotEmpty;

    var numberOfChanges = 0;
    if (taskExists) {
      final databaseModel = DatabaseModel();
      final database = await databaseModel.getDatabase();

      numberOfChanges = await database.update(
        _tableName,
        toMap(task),
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }

    return numberOfChanges;
  }

  Future<int> delete(String taskName) async {
    debugPrint('delete');

    final tasks = await find(taskName);
    final taskExists = tasks.isNotEmpty;

    var numberOfChanges = 0;
    if (taskExists) {
      final databaseModel = DatabaseModel();
      final database = await databaseModel.getDatabase();

      numberOfChanges = await database
          .delete(_tableName, where: '$_name = ?', whereArgs: [taskName]);
    }

    return numberOfChanges;
  }
}
