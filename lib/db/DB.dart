import 'package:todo_app/db/database.dart';

class DB {
  static AppDatabase _db;

  static Future<void> initDB() async {
    _db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  // static Future<AppDatabase> getDBInstance() async {
  //   if (_db == null) {
  //     _db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //   }
  //   return _db;
  // }

  static AppDatabase getDBInstance() {
    return _db;
  }
}
