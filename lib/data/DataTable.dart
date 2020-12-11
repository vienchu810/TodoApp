import 'package:frame1/data/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:frame1/model/todo.dart';
import 'package:frame1/data/DataTable.dart';

class datatable{
  static const tablename = 'todo';
  static const columnId = 'id';
  static const columncongviec = 'congviec';
  static const columnDate = 'date';

  static const Createtable = ''' CREATE TABLE $tablename (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columncongviec TEXT NOT NULL,
      $columnDate TEXT NOT NULL);''';
  static const Droptable = ''' DROP TABLE IF EX $tablename''';

// SQL code to create the database table
//  Future _onCreate(Database db, int version) async {
//    await db.execute(''' CREATE TABLE $table (
//      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//      $columncongviec TEXT NOT NULL,
//      $columnDate TEXT NOT NULL)''');
//  }

  Future<int> insert(todo to) async {
    final Database db = DatabaseHelper.instance.database;
    return db.insert(tablename, to.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> delete(todo td) async {
    final Database db =  DatabaseHelper.instance.database;
    return await db
        .delete(tablename, where: '$columnId = ?', whereArgs: [td.id]);
  }

  Future<void> clearTable() async {
    Database db =  DatabaseHelper.instance.database;
    return await db.rawQuery("DELETE FROM $tablename");
  }

  Future<List<todo>> sellectAll() async {
    final Database db =  DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> map = await db.query('todo');
    return List.generate(map.length, (index) {
      return todo.fromData(
        map[index]['id'],
        map[index]['congviec'],
        map[index]['date'],
      );
    });
  }
}