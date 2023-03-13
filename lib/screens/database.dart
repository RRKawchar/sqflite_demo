import 'package:flutter/material.dart';

class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){}, child: const Text("Create")),
            ElevatedButton(onPressed: (){}, child: const Text("Read")),
            ElevatedButton(onPressed: (){}, child: const Text("Update")),
            ElevatedButton(onPressed: (){}, child: const Text("Delete")),
          ],
        ),
      ),
    );
  }
}
