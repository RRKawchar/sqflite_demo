import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite_demo/api_demo/model/product_model.dart';

class ApiController extends GetxController {
  final String apiUrl = 'https://www.mffoodmart.com/wp-json/wc/v2/products';

  Future<List<ProductModel>> getProducts() async {

    try{

      final response = await http.get(
        Uri.parse('$apiUrl?page=1'),
        headers: {
          'Authorization': 'Basic ' +
              base64Encode(
                  utf8.encode('ck_389df1912d9d0be0541ee41dc1e3fcbfb367bbf9:cs_643aea4269872c4005d4a106676bcd07e96af983')),
        },
      );

      if (response.statusCode == 200) {
        List<ProductModel> products = (jsonDecode(response.body) as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }

    }catch(e){
      print(e.toString());
      throw Exception("failed to load data $e");
    }

  }
}
