
import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';

class ShowList extends StatelessWidget {
  // const ShowList(this.quickList, {super.key});
  const ShowList(this.quickList, {super.key});

  final QuickList quickList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quickList.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
        children: [
            Text('Hello')
          ],
        ),
      )
    );
  }
}
