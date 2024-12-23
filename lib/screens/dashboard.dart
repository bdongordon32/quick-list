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
  List<QuickList> quickLists = [];
  // // late Future<List<QuickList>> quickLists;
  

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
          List<QuickList> documentItems = quickLists;
          documentItems.add(listItem);
          
          setState(() { quickLists = documentItems; });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: QuickListContainer(quickLists),
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
