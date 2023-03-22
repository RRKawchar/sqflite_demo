import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/practice_demo/model/cart_model.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._privateConstructor();
  static final CartDatabaseHelper instance =
      CartDatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart_items.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: createTable,
    );
  }


  void createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        price REAL,
        image TEXT
      )
      ''');
  }

  Future<int> insertCartItem(CartModel cartItem) async {
    final db = await database;

    return await db.insert(
      'cart_items',
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartModel>> getCartItems() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('cart_items');

    return List.generate(maps.length, (i) {
      return CartModel.fromMap(maps[i]);
    });
  }
}
