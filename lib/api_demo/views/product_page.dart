import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_demo/api_demo/controller/product_controller_two.dart';

class ProductListTwoWidget extends StatelessWidget {
  final ProductControllerTwo _productController = Get.put(ProductControllerTwo());

   ProductListTwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List (Pagination)'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _productController.loadMore();
          }
          return true;
        },
        child: Column(
          children: [
            Expanded(child: _productController.buildProductList()),
            Obx(() {
              if (_productController.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
