import 'dart:convert';

import 'package:sqlite_demo/api_demo_two/models/countries_model.dart';
import 'package:http/http.dart'as http;
class CountriesApiService{


 static Future<List<CountriesModel>>  getCountries()async{
   const url="https://restcountries.com/v3.1/all";
    final response = await http.get(Uri.parse(url));
     print('-------------------status code :${response.statusCode}');
     print('-------------------status body :${response.body}');
    if(response.statusCode==200){
      final data = json.decode(response.body);
       print('................json : $data');
      return List<CountriesModel>.from(
          data.map((json) => CountriesModel.fromJson(json)));
    }else {
      throw Exception("Failed to Load data");
    }

  }
}