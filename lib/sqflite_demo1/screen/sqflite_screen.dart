import 'package:flutter/material.dart';
import 'package:sqlite_demo/sqflite_demo1/db_helper/database_helper.dart';
import 'package:sqlite_demo/sqflite_demo1/model/grocery.dart';

class SqfliteScreen extends StatefulWidget {
  const SqfliteScreen({Key? key}) : super(key: key);

  @override
  State<SqfliteScreen> createState() => _SqfliteScreenState();
}

class _SqfliteScreenState extends State<SqfliteScreen> {
  int? selectedId;
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: TextField(
        controller: textController,
      )),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getGroceries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("loading......"),
            );
          } else {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No groceries in List"),
                  )
                : ListView(
                    children: snapshot.data!.map((grocery) {
                      return Center(
                        child: Card(
                          color: selectedId == grocery.id
                              ? Colors.grey
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                textController.text = grocery.name;
                                selectedId = grocery.id;
                              });
                            },
                            onLongPress: () async {
                              await DatabaseHelper.instance
                                  .removed(grocery.id!);
                            },
                            title: Text(grocery.name),
                            trailing: IconButton(
                              onPressed: () async {
                                await DatabaseHelper.instance
                                    .removed(grocery.id!);

                                setState(() {
                                  grocery.name!='';
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          selectedId != null
              ? await DatabaseHelper.instance.updateData(
                  Grocery(id: selectedId, name: textController.text))
              : await DatabaseHelper.instance
                  .addGrocery(Grocery(name: textController.text));
          setState(() {
            textController.clear();
            selectedId = null;
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
