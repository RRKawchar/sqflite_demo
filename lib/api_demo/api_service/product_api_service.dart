import 'dart:convert';

import 'package:sqlite_demo/api_demo/model/product_model_two.dart';
import 'package:http/http.dart'as http;
class ProductService {
  final String apiURL = "https://www.mffoodmart.com/wp-json/wc/v2/products";
  final String username = "ck_389df1912d9d0be0541ee41dc1e3fcbfb367bbf9";
  final String password = "cs_643aea4269872c4005d4a106676bcd07e96af983";

  Future<List<ProductModelTwo>> getProducts({int page = 1, int perPage = 10}) async {
    final response = await http.get(
      Uri.parse('$apiURL?page=$page&per_page=$perPage'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductModelTwo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
