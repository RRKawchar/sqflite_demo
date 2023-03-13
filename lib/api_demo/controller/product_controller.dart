import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqlite_demo/api_demo/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;

  var isLoading = false.obs;
  var currentPage = 1.obs;


  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }
  Future<void> fetchProduct() async {
    String username = 'ck_389df1912d9d0be0541ee41dc1e3fcbfb367bbf9';
    String password = 'cs_643aea4269872c4005d4a106676bcd07e96af983';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    try {
      isLoading(true);

      var url =
          "https://www.mffoodmart.com/wp-json/wc/v2/products?page=${currentPage.value}";

      final response = await http.get(Uri.parse(url),
          headers: <String, String>{'authorization': basicAuth});
      print("---------Status Code---${response.statusCode}");
      print("-----------Body---${response.body}");

        final List<ProductModel> productList =
        (jsonDecode(response.body) as List).map((json) => ProductModel.fromJson(json)).toList();
        productList.addAll(productList);

        print("+++++++++++++++++$productList");

    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshProduct()async{

    productList.clear();
    currentPage.value=1;
    fetchProduct();
  }

  void nextPage(){
    currentPage.value++;
    fetchProduct();
  }

  bool onScrollNotification(ScrollNotification scrollNotification){
    if(isLoading.value&&scrollNotification.metrics.pixels==scrollNotification.metrics.maxScrollExtent){
      nextPage();
    }
    return true;
  }
}
