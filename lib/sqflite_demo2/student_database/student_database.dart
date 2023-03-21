import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/sqflite_demo2/model/student.dart';

class StudentDatabase{

  StudentDatabase._privateConstructor();
  static final StudentDatabase instance= StudentDatabase._privateConstructor();
  static Database? _database;
  Future<Database> get database async=>_database ??=await _initDatabase();


  Future<Database> _initDatabase()async{
    Directory documentDirectory= await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path, 'groceries.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version)async{
    await db.execute(
        '''CREATE TABLE groceries(
         id INTEGER PRIMARY KEY,
         name TEXT
       )'''

    );
  }


  // fatherName TEXT,
  // motherName TEXT,
  // mobile TEXT,
  // age TEXT,
  // image TEXT,

  Future<int> addGrocery(Student grocery)async{

    Database db=await instance.database;
    return await db.insert('groceries', grocery.toJson());
  }

  Future<List<Student>> getGroceries()async{

    Database db=await instance.database;

    var groceries= await db.query('groceries',orderBy: 'name');
    List<Student> groceryList= groceries.isNotEmpty?groceries.map((e) => Student.fromJson(e)).toList():[];

    return groceryList;

  }
}