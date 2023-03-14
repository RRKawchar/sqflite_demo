import 'dart:convert';

import 'package:sqlite_demo/api_demo/model/product_model_two.dart';
import 'package:http/http.dart'as http;
class ApiService{

  Future<List<ProductModelTwo>> getProducts({int page=1,int perPage=10})async{

    try{
      final url=Uri.parse("https://www.mffoodmart.com/wp-json/wc/v2/products").replace(
          queryParameters: {'per_page':perPage.toString(),'page':page.toString()}
      );
      final headers = {
        'Authorization': 'Basic ${base64Encode(utf8.encode('ck_389df1912d9d0be0541ee41dc1e3fcbfb367bbf9:cs_643aea4269872c4005d4a106676bcd07e96af983'))}',
      };

      final response =await http.get((url),headers: headers);

      if(response.statusCode==200){
        final product=jsonDecode(response.body)as List;
        print("===================$product");
        final List<ProductModelTwo> productJson=product.map((json) => ProductModelTwo.fromJson(json)).toList();
        print("---------------------$productJson");
        return productJson;

      }else{
        throw Exception('Request fail to status code ${response.statusCode}');
      }
    }catch(e){
      print("$e");
      throw Exception("Exception here $e");
    }




  }


  final String apiURL = "https://www.mffoodmart.com/wp-json/wc/v2/products";
  final String username = "ck_389df1912d9d0be0541ee41dc1e3fcbfb367bbf9";
  final String password = "cs_643aea4269872c4005d4a106676bcd07e96af983";

  Future<List<ProductModelTwo>> fetchProducts() async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await http.get(Uri.parse(apiURL), headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);
      return productsJson.map((json) => ProductModelTwo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}