import 'package:flutter/material.dart';
import 'package:sqlite_demo/grocery_demo/database_helper/product_db_helper.dart';
import 'package:sqlite_demo/grocery_demo/model/product_model.dart';

class ProductShowScreen extends StatefulWidget {
  @override
  _ProductShowScreenState createState() => _ProductShowScreenState();
}

class _ProductShowScreenState extends State<ProductShowScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  List<Product> _products = [];

  void _toggleFavorite(Product product) async {
    product.isFavorite = !product.isFavorite;
    await dbHelper.updateFavorite(product);
    setState(() {
      _products[_products.indexWhere((p) => p.id == product.id)] = product;
    });
  }

  Future<void> _fetchFavorites() async {
    List<Product> products = await dbHelper.getFavorites();
    setState(() {
      _products = products;
    });
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      Product product = Product(
        id:0,
        name: _nameController.text,
        image: _imageController.text,
        isFavorite: true,
      );
      int id = await dbHelper.insert(product);
      product.id = id;
      setState(() {
        _products.add(product);
      });
      _nameController.clear();
      _imageController.clear();
      _fetchFavorites();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Favorite Products'),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a product name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an image URL';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _addProduct,
                    child: Text('Add to Favorites'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(_products[index].image),
                    title: Text(_products[index].name),
                    trailing: IconButton(
                      icon: Icon(
                        _products[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () => _toggleFavorite(_products[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
