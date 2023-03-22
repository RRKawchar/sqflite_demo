import 'package:flutter/material.dart';
import 'package:sqlite_demo/sqflite_demo2/model/student.dart';
import 'package:sqlite_demo/sqflite_demo2/student_database/student_database.dart';

class DataShowScreen extends StatefulWidget {
  const DataShowScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DataShowScreen> createState() => _DataShowScreenState();
}

class _DataShowScreenState extends State<DataShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
      body: FutureBuilder<List<Student>>(
        future: StudentDatabase.instance.getGroceries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Loading....."),
            );
          } else {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text("No Student data found"),
                  )
                : ListView(
                    children: snapshot.data!.map((student) {
                      return Card(
                          child: ListTile(
                        title: Text(student.name),
                        trailing: IconButton(
                          onPressed: () async {
                            await StudentDatabase.instance.removed(student.id!);

                            setState(() {
                              student.name != '';
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ));
                    }).toList(),
                  );
            //     :ListView.builder(
            //     itemCount: snapshot.data!.length,
            //     itemBuilder: (context,index){
            //         return Card(
            //           child: ListTile(
            //             title: Text(snapshot.data![index].name),
            //             trailing: IconButton(
            //               onPressed: ()async{
            //                 await StudentDatabase.instance.removed(snapshot.data![index].id!);
            //
            //                 setState(() {
            //                   snapshot.data![index].name!='';
            //                 });
            //               },
            //               icon: const Icon(Icons.delete),
            //             ),
            //           )
            //         );
            //
            // });
          }
        },
      ),
    );
  }
}
