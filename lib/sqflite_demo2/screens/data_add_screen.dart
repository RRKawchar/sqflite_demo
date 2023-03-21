import 'package:flutter/material.dart';
import 'package:sqlite_demo/sqflite_demo2/model/student.dart';
import 'package:sqlite_demo/sqflite_demo2/screens/data_show_screen.dart';
import 'package:sqlite_demo/sqflite_demo2/student_database/student_database.dart';

class DataAddScreen extends StatefulWidget {
  const DataAddScreen({Key? key}) : super(key: key);

  @override
  State<DataAddScreen> createState() => _DataAddScreenState();
}

class _DataAddScreenState extends State<DataAddScreen> {
  final nameController = TextEditingController();
  // final ftController = TextEditingController();
  // final moController = TextEditingController();
  // final mobileController = TextEditingController();
  // final ageController = TextEditingController();
  // final String image =
  //     "https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Favourite Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildTextField(controller: nameController, hintText: "name"),
            // buildTextField(controller: ftController, hintText: "Father Name"),
            // buildTextField(controller: moController, hintText: "Mother Name"),
            // buildTextField(controller: mobileController, hintText: "Mobile"),
            // buildTextField(controller: ageController, hintText: "Age"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 50,
          width: double.infinity,
          child: MaterialButton(
            shape: const StadiumBorder(),
            color: Colors.green,
            onPressed: ()async {
              await StudentDatabase.instance.addGrocery(
              Student(
                    name:  nameController.text,
                    // fatherName: ftController.text,
                    // motherName: moController.text,
                    // mobile: mobileController.text,
                    // age: ageController.text,
                    // image: image
                )
              );


              setState(() {
                nameController.clear();
                // ftController.clear();
                // moController.clear();
                // mobileController.clear();
              });
            },
            child: const Text("Submit"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const DataShowScreen()));
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  TextField buildTextField(
      {required String hintText, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
