import 'package:flutter/material.dart';
import 'package:quick_list/widgets/quick_list_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> listItems = [];

  void addNewList() {
    List<String> tempItems = listItems;
    tempItems.add('5');

    setState(() {
      listItems = tempItems;
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
