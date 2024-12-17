import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void addNewList() {
    print("Adding new");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF5D6B85),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Dashboard')
          ],
        ),
      ),
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
