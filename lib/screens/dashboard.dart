import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/screens/new_list.dart';
import 'package:quick_list/widgets/quick_list_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<QuickList> listItems = [];
  // // late Future<List<QuickList>> listItems;
  

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  void addNewList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewList()),
    );
  }

  @override
  void initState() {
    super.initState();

    fireDb.collection('lists').get()
      .then((event) {
        for (var doc in event.docs) {
          QuickList listItem = QuickList.fromSnapshot(doc);
          List<QuickList> documentItems = listItems;
          documentItems.add(listItem);
          
          setState(() { listItems = documentItems; });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: QuickListContainer(listItems),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewList,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
