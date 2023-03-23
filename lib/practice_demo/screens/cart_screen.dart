import 'package:flutter/material.dart';
import 'package:sqlite_demo/practice_demo/cart_database/cart-database_helper.dart';
import 'package:sqlite_demo/practice_demo/model/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartModel> _cartItems = [];
    @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

    void _loadCartItems() async {

    final items = await CartDatabaseHelper.instance.getCartItems();
    setState(() {
      _cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
         itemCount: _cartItems.length,
          itemBuilder: (context,index){
        return Card(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(_cartItems[index].image.toString()),
              ),
              ListTile(
                title: Text(_cartItems[index].name.toString()),
                subtitle: Text(_cartItems[index].price.toString()),
              ),
            ],
          ),
        );
      }),
    );
  }
}
