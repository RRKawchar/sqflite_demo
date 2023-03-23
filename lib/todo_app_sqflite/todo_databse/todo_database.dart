import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/todo_app_sqflite/todo_model/todo_model.dart';

class TodoDatabase{

  TodoDatabase._privateConstructor();


  static final TodoDatabase instance=TodoDatabase._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();


  Future<Database> _initDatabase()async{
    Directory documentDirectory= await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path,'todos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate

    );
  }

  Future _onCreate(Database db, int version)async{

    await db.execute(
      """
      CREATE TABLE todos(
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT
      )
      
      """
    );

  }
  Future<int> addTodo(TodoModel todoModel)async{

    Database db=await instance.database;

    return await db.insert('todos', todoModel.toJson());

  }



  Future<List<TodoModel>> getTodos()async{
    Database db=await instance.database;

    var todos= await db.query('todos',orderBy: 'id');
    List<TodoModel> _todos=todos.isNotEmpty?todos.map((todo) => TodoModel.fromJson(todo)).toList():[];

    return _todos;
  }
}



