import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:frame1/model/todo.dart';
import 'package:frame1/data/DataTable.dart';

class DatabaseHelper {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;
  static Database _database;


  static const initScrip = [datatable.Createtable];
  static const migration = [datatable.Createtable];

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();
  Database get database =>_database;

  initDatabase() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), _databaseName), onCreate: (db, version) {
      initScrip.forEach((script) async => await db.execute(script));
    }, onUpgrade: (db, oldVersion, newVersion) {
      migration.forEach((script) async => await db.execute(script));
    }, version: _databaseVersion);
  }


}
