import 'package:flutter/material.dart';
import 'package:sqlite_demo/sqflite_demo2/model/student.dart';
import 'package:sqlite_demo/sqflite_demo2/student_database/db_helper.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AddDataScreen> {
  List<Student> students = [];
  final dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    refreshStudents();
  }

  void refreshStudents() async {
    List<Student> list = await dbHelper.getStudents();
    setState(() {
      students = list;
    });
  }

  void addStudent() async {
    Student student = Student(
      name: 'John Doe',
      age: 20,
      grade: 4.0,
    );
    await dbHelper.insertStudent(student);
    refreshStudents();
  }

  void deleteStudent(Student student) async {
    await dbHelper.deleteStudent(student.id!);
    refreshStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Database'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (BuildContext context, int index) {
          Student student = students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text('Age: ${student.age} | Grade: ${student.grade}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteStudent(student),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
