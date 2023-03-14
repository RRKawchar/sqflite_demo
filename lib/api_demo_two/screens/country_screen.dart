import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqlite_demo/api_demo_two/models/countries_model.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<CountriesModel>>? _future;

  @override
  void initState() {
    super.initState();
    _future = fetchCountries();
  }


  Future<List<CountriesModel>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      final List<dynamic>? data = json.decode(response.body);
      if (data != null) {
        return data.map((json) => CountriesModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to parse countries');
      }
    } else {
      throw Exception('Failed to load countries');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
      ),
      body: Center(
        child: FutureBuilder<List<CountriesModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final country = snapshot.data![index];
                  return ListTile(
                    title: Text(country.name!.common.toString()),
                    subtitle: Text('Capital: ${country.capital}, Population: ${country.population}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
