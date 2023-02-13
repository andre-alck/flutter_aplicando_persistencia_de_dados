import 'package:flutter_aplicando_persistencia_de_dados/src/modules/shared/models/task_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseModel {
  Future<Database> getDatabase() async {
    final databasePath = join(await getDatabasesPath(), 'task_b.db');
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) => db.execute(TaskDao.createQuery),
      version: 4,
    );

    return database;
  }
}
