import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/sqflite_demo2/model/student.dart';

class DBHelper {
  static late Database _db;
  static const String DB_NAME = 'my_db.db';

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            grade REAL
          )
        ''');
      },
    );
  }

  Future<int> insertStudent(Student student) async {
    var dbClient = await database;
    return await dbClient.insert('Students', student.toJson());
  }

  Future<int> updateStudent(Student student) async {
    var dbClient = await database;
    return await dbClient.update(
      'Students',
      student.toJson(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    var dbClient = await database;
    return await dbClient.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query('Students');
    List<Student> students = [];
    if (maps.length > 0) {
      maps.forEach((map) => students.add(Student.fromJson(map)));
    }
    return students;
  }
}
