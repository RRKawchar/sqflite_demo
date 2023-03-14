import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_demo/api_demo/controller/api_controller.dart';
import 'package:sqlite_demo/api_demo/model/product_model.dart';

class MyWidget extends StatelessWidget {
  final  apiService = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: FutureBuilder<List<ProductModel>>(
        future: apiService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ProductModel product = snapshot.data![index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
