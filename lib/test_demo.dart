// class CartItem {
//   int id;
//   String productName;
//   double productPrice;
//   int productQuantity;
//   String productImage;
//
//   CartItem({
//     this.id,
//     this.productName,
//     this.productPrice,
//     this.productQuantity,
//     this.productImage,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'productName': productName,
//       'productPrice': productPrice,
//       'productQuantity': productQuantity,
//       'productImage': productImage,
//     };
//   }
//
//   static CartItem fromMap(Map<String, dynamic> map) {
//     return CartItem(
//       id: map['id'],
//       productName: map['productName'],
//       productPrice: map['productPrice'],
//       productQuantity: map['productQuantity'],
//       productImage: map['productImage'],
//     );
//   }
// }
//
// class CartDatabaseHelper {
//   static final CartDatabaseHelper _instance = CartDatabaseHelper._();
//
//   static Database _database;
//
//   CartDatabaseHelper._();
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database;
//     }
//
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'cart_database.db');
//
//     return await openDatabase(path, version: 1, onCreate: _createDatabase);
//   }
//
//   void _createDatabase(Database db, int version) async {
//     await db.execute('''CREATE TABLE cart_items (
//       id INTEGER PRIMARY KEY,
//       productName TEXT,
//       productPrice REAL,
//       productQuantity INTEGER,
//       productImage TEXT
//     )''');
//   }
//
//   Future<int> insertCartItem(CartItem cartItem) async {
//     final db = await database;
//
//     return await db.insert('cart_items', cartItem.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<List<CartItem>> getCartItems() async {
//     final db = await database;
//
//     final List<Map<String, dynamic>> maps = await db.query('cart_items');
//
//     return List.generate(maps.length, (i) {
//       return CartItem.fromMap(maps[i]);
//     });
//   }
// }



// CartItem cartItem = CartItem(
//   productName: 'Product 1',
//   productPrice: 10.99,
//   productQuantity: 2,
//   productImage: 'image_url',
// );
//
// CartDatabaseHelper dbHelper = CartDatabaseHelper();
//
// await dbHelper.insertCartItem(cartItem);



// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   List<CartItem> _cartItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCartItems();
//   }
//
//   void _loadCartItems() async {
//     final dbHelper = CartDatabaseHelper();
//     final items = await dbHelper.getCartItems();
//     setState(() {
//       _cartItems = items;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('Cart'),
//     ),
//     body: ListView.builder(
//     itemCount: _cartItems.length,
//     itemBuilder: (context, index) {
//     return Card(
//     child: ListTile(
//     title: Text(_cartItems[index].productName),
//     subtitle: Text('Price: \$${_cartItems[index].productPrice}'),
//     trailing: Text('Qty: ${_cartItems[index].
