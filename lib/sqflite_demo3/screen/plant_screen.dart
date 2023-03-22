import 'package:flutter/material.dart';
import 'package:sqlite_demo/sqflite_demo3/db_h/data_base.dart';
import 'package:sqlite_demo/sqflite_demo3/model/plants.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {


  late DataBase handler;
  Future<int> addPlanets() async {
    Planets firstPlanet =
    Planets(name: "Green Chilli", age: 24, distancefromsun: 10);
    Planets secondPlanet =
    Planets(name: "Red Chili", age: 31, distancefromsun: 20);
    Planets thirdPlanet =
    Planets( name: 'Onion', age: 4, distancefromsun: 30);
    Planets fourthPlanet =
    Planets( name: 'Banana', age: 5, distancefromsun: 40);

    List<Planets> planets = [firstPlanet, secondPlanet,thirdPlanet,fourthPlanet];
    return await handler.insertPlanets(planets);
  }


  @override
  void initState() {
    super.initState();
    handler = DataBase();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.retrievePlanets(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Planets>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].age.toString()),
                    trailing: IconButton(
                      onPressed: (){
                        handler.deletePlanet(snapshot.data![index].id!);
                           setState(() {
                             snapshot.data![index].name!='';
                             snapshot.data![index].age.toString()=='';
                           });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
         await addPlanets();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
