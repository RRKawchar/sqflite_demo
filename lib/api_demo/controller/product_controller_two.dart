import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_demo/api_demo/api_service/product_api_service.dart';
import 'package:sqlite_demo/api_demo/model/product_model_two.dart';

class ProductControllerTwo extends GetxController {
  final ProductService _productService = ProductService();
  var productList = <ProductModelTwo>[].obs;
  var isLoading = false.obs;
  int page = 1;
  int perPage = 15;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      List<ProductModelTwo> data = await _productService.getProducts(page: page, perPage: perPage);
      productList.addAll(data);
      page++;

    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> refresh() async {
    try {
      productList.clear();
      page = 1;
      isLoading(true);
      var products = await _productService.getProducts();
      if (products != null) {
        productList.addAll(products);
        page++;
      }
    } finally {
      isLoading(false);
    }
  }

  void loadMore() {
    if (!isLoading.value) {
      fetchProducts();
    }
  }

  Widget buildProductList() {
    return Obx(() {
      if (productList.isEmpty && isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (productList.isEmpty && !isLoading.value) {
        return const Center(child: Text('No products found.'));
      } else {
        var rndItem = productList.shuffle();
        return ListView.builder(
          itemCount: productList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < productList.length) {
              ProductModelTwo product = productList[index];
              return ListTile(
                leading: Image.network(product.images.first.src),
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
              );
            } else if (isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        );
      }
    });
  }
}
