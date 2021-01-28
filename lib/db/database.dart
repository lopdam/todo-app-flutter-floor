import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app/dao/task_dao.dart';
import 'package:todo_app/models/task.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
