import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/sqflite_demo1/model/grocery.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'groceries.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE groceries(
         id INTEGER PRIMARY KEY,
         name TEXT
       )''');
  }

  Future<Iterable<Grocery>> getGroceries() async {
    Database db = await instance.database;

    var groceries = await db.query('groceries', orderBy: 'name');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((e) => Grocery.fromMap(e)).toList()
        : [];
    var newList = groceryList.reversed;
    return newList;
  }

  Future<int> addGrocery(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert('groceries', grocery.toMap());
  }

  Future<int> removed(int id) async {
    Database db = await instance.database;
    return await db.delete('groceries', where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateData(Grocery grocery) async {
    Database db = await instance.database;

    return await db.update('groceries', grocery.toMap(),
        where: 'id=?', whereArgs: [grocery.id]);
  }
}
