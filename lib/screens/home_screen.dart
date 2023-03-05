import 'package:flutter/material.dart';
import 'package:sqlite_demo/helper/sqlite_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<Map<String,dynamic>> _journal=[];
   bool _isLoading=true;

  void _refreshJournals()async{

    final data=await SQLHelper.getItems();
    setState(() {
      _journal=data;
      _isLoading=false;
    });
  }

  @override
  void initState() {
   _refreshJournals();
   print('..number of items ${_journal.length}');
    super.initState();
  }


  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();

  void _showFrom(int?id)async{

    if(id!=null){

      final existingJournal=_journal.firstWhere((element) => element['id']==id);
      _titleController.text=existingJournal['title'];
      _descriptionController.text=existingJournal['description'];
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
