import 'package:flutter_aplicando_persistencia_de_dados/data/task_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String databasePath = join(await getDatabasesPath(), 'task.db');
  return openDatabase(databasePath,
      onCreate: (db, version) => db.execute(TaskDao.createQuery));
}
