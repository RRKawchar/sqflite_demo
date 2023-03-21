import 'package:flutter/material.dart';
import 'package:sqlite_demo/sqflite_demo2/model/student.dart';
import 'package:sqlite_demo/sqflite_demo2/student_database/student_database.dart';

class DataShowScreen extends StatefulWidget {

 const DataShowScreen({Key? key,}) : super(key: key);

  @override
  State<DataShowScreen> createState() => _DataShowScreenState();
}

class _DataShowScreenState extends State<DataShowScreen> {

List<Student> studentList=[];

@override
  void initState() {
    getStudentData();
    super.initState();
  }

  getStudentData()async{

    studentList = await StudentDatabase.instance.getGroceries();
    print('================ $studentList');
    print("=++++++++++++ ${studentList.first.id}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Student>>(
          future: StudentDatabase.instance.getGroceries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // final cartItems = snapshot.data!;
                // double totalPrice = cartItems.fold(
                //     0.0, (total, item) => total + item.price * item.quantity);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Text(snapshot.data!.first.name,),
                      // Text(
                      //   'Total: \$${totalPrice.toStringAsFixed(2)}',
                      //   style: TextStyle(fontSize: 20.0),
                      // ),
                      SizedBox(height: 16.0),
                      // ElevatedButton(
                      //   child: Text('Checkout'),
                      //   onPressed: () {
                      //     // _checkout();
                      //   },
                      // ),
                    ],
                  ),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
    )
)

    );



  }

}
