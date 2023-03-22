import 'package:flutter/material.dart';
import 'package:sqlite_demo/practice_demo/model/cart_database/cart-database_helper.dart';
import 'package:sqlite_demo/practice_demo/model/cart_model.dart';

class ProductDetailsScreen extends StatefulWidget {

  final String image;
  final String name;
  final String description;
  final String price;
  const ProductDetailsScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(widget.name),
      ),
      body: ListView(
        padding:const EdgeInsets.all(10),
        children: [
          Container(
            height: 250,
            width: size.width,
            child: Image.network(widget.image),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("\$ ${widget.price}"),
          const SizedBox(
            height: 10,
          ),
          Text(widget.name),
          const SizedBox(
            height: 10,
          ),
          Text(widget.description),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.orangeAccent,
          shape: StadiumBorder(),
          onPressed: _addToCart,
          child: const Text('Add To Cart'),
        ),
      ),
    );
  }

  _addToCart(){
   CartModel cartModel=CartModel(
     description: widget.description,
     image: widget.image,
     name: widget.name,
     price: widget.price
   );
   print('------------------------------------$cartModel');
    CartDatabaseHelper.instance.insertCartItem(cartModel);

  }
}
