import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';

class QuickListCard extends StatelessWidget {
  const QuickListCard(this.quickList, { super.key });

  final QuickList quickList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Text(quickList.title),
    );
  }
}
