import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sqlite_demo/api_demo/views/product_page.dart';
import 'package:sqlite_demo/api_demo_two/screens/country_screen.dart';
import 'package:sqlite_demo/practice_demo/screens/chili_screen.dart';
import 'package:sqlite_demo/grocery_demo/screen/product_show_screen.dart';
import 'package:sqlite_demo/sqflite_demo1/screen/sqflite_screen.dart';
import 'package:sqlite_demo/sqflite_demo2/screens/data_add_screen.dart';
import 'package:sqlite_demo/sqflite_demo2/screens/data_show_screen.dart';
import 'package:sqlite_demo/sqflite_demo3/screen/plant_screen.dart';
import 'package:sqlite_demo/todo_app_sqflite/todo_screen/todo_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  TodoScreen(),
    );
  }
}

