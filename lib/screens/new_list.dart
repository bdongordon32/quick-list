import 'package:flutter/material.dart';

class NewList extends StatefulWidget {
  const NewList({ super.key });

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New List'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      )
    );
  }
}
