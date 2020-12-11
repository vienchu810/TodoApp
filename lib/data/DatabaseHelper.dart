//import 'package:frame1/model/todo.dart';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:sqflite/sqlite_api.dart';
//
//class DatabaseHelper {
//  static final _databaseName = "todo.db";
//  static final _databaseVersion = 1;
//
//  static final table = 'todo';
//
//  static final columnId = 'id';
//  static final columnTitle = 'congviec';
//  static final columnDate = 'date';
//
//  DatabaseHelper._privateConstructor();
//
//  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//  static Database _database;
//
//  Future<Database> get database async {
//    if (_database != null) return _database;
//    _database = await initDatabase();
//    return _database;
//  }
//
//  initDatabase() async {
//    String path = join(await getDatabasesPath(), _databaseName);
//    return await openDatabase(path,
//        version: _databaseVersion, onCreate: _onCreate);
//  }
//
//  // SQL code to create the database table
//  Future _onCreate(Database db, int version) async {
//    await db.execute(''' CREATE TABLE $table (
//      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//      $columnTitle TEXT NOT NULL,
//      $columnDate TEXT NOT NULL)''');
//  }
//
//  Future<int> insert(todo to) async {
//    Database db = await instance.database;
//    var res = await db.insert(table, to.toMap());
//    return res;
//  }
//
//  Future<List<Map<String, dynamic>>> queryAllRows() async {
//    Database db = await instance.database;
//    var res = await db.query(table, orderBy: "$columnId DESC");
//    return res;
//  }
//
//  Future<List<todo>> sellectAll() async {
//    final Database db = await instance.database;
//    final List<Map<String, dynamic>> map = await db.query('todo.db');
//    return List.generate(map.length, (index) {
//      return todo.fromData(
//        map[index]['id'],
//        map[index]['congviec'],
//        map[index]['date'],
//      );
//    });
//  }
//
//  Future<int> delete(int id) async {
//    Database db = await instance.database;
//    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//  }
//
//  Future<void> clearTable() async {
//    Database db = await instance.database;
//    return await db.rawQuery("DELETE FROM $table");
//  }
//}
