import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqlite_demo/todo_app_sqflite/todo_databse/todo_database.dart';
import 'package:sqlite_demo/todo_app_sqflite/todo_model/todo_model.dart';
class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final titleController=TextEditingController();
  final descriptionController=TextEditingController();

  Random _random=Random();

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen"),
      ),
      body: Column(
        children: [

          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Title"
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: "description"
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading?Center(child: CircularProgressIndicator(),):ElevatedButton(
                  onPressed: ()async{
                    setState(() {
                      isLoading=true;
                    });
                    final todo=TodoModel(
                      id: _random.nextInt(100),
                      title: titleController.text,
                      description: descriptionController.text

                    );
                    await TodoDatabase.instance.addTodo(todo);
                    setState(() {
                      isLoading=false;
                    });
                  },
                  child: const Text("Insert"),
                ),
              )),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){

                  },
                  child: const Text("Update"),
                ),
              ))
            ],
          ),

          Expanded(
            child: FutureBuilder(
              future: TodoDatabase.instance.getTodos(),
              builder: (context,AsyncSnapshot<List<TodoModel>>snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }else{
                  return snapshot.data==null? const Center(child: Text("Todo is Empty"),):ListView(
                    children: snapshot.data!.map((todo){
                      return ListTile(
                        title: Text(todo.title!),
                        subtitle: Text(todo.description!),
                      );
                    }).toList(),
                  );
                }
              },
            )

          )
        ],
      ),
    );
  }
}
