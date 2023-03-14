import 'package:flutter/material.dart';
import 'package:sqlite_demo/api_demo/model/product_model_two.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductModelTwo> products;

  ProductListWidget({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModelTwo product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text(product.price),
          );
        },
      ),
    );
  }
}
