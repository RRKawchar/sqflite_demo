import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_demo/grocery_demo/model/product_model.dart';

class DBHelper {
  static Database? _db;
  static const String DB_NAME = 'products.db';
  static const int DB_VERSION = 1;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    return await openDatabase(path, version: DB_VERSION,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, image TEXT, isFavorite INTEGER)');
        });
  }

  Future<int> insert(Product product) async {
    var dbClient = await db;
    return await dbClient.insert('products', product.toMap());
  }

  Future<List<Product>> getFavorites() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('products',
        where: 'isFavorite = ?',
        whereArgs: [1],
        columns: ['id', 'name', 'image', 'isFavorite']);
    List<Product> products = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        products.add(Product.fromMap(maps[i]));
      }
    }
    return products;
  }

  Future<int> updateFavorite(Product product) async {
    var dbClient = await db;
    return await dbClient.update('products', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int> delete(Product product) async {
    var dbClient = await db;
    return await dbClient.delete('products', where: 'id = ?', whereArgs: [product.id]);
  }
}