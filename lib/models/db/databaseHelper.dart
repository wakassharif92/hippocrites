import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final _databaseName = "MyDatabase.db";
  final _databaseVersion = 2;

  static final tbl_results_history = 'tbl_results_history';
  static final rh_id = 'rh_id';
  static final rh_title = 'rh_title';
  static final rh_user_id = 'rh_user_id';
  static final rh_description = 'rh_description';
  static final rh_treatments = 'rh_treatments';
  static final rh_preventation = 'rh_preventation';
  static final rh_type = 'rh_type';

  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._internal();

  // make this a singleton class
  //  DatabaseHelper._privateConstructor();
  // static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {

    await db.execute('''
          CREATE TABLE $tbl_results_history (
            $rh_id INTEGER PRIMARY KEY,
            $rh_user_id TEXT,
            $rh_description BLOB
            )
          ''');
    // $rh_user_id TEXT,
    //     $rh_title  TEXT,
    // $rh_treatments TEXT,
    //     $rh_preventation TEXT
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(tbl_name, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tbl_name, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> selectAllRows(tbl_name) async {
    Database? db = await instance.database;
    return await db!.query(tbl_name);
  }

  Future<int> deleteRows(tbl, deleteWhere, argsArray) async {
    Database? db = await instance.database;

    return await db!.delete(tbl, where: deleteWhere, whereArgs: [argsArray]);
  }

  Future<List<Map<String, dynamic>>> selectRowWhere(tbl_name, where) async {
    Database? db = await instance.database;
    return await db!.rawQuery("select * from $tbl_name where ${where}");
  }



}
