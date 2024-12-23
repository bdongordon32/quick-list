import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';

class QuickListCard extends StatelessWidget {
  const QuickListCard(this.quickList, { super.key });

  final QuickList quickList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(
          color: primaryDarkAccent,
          width: 2
        )
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quickList.title,
            style: TextStyle(
              fontSize: 20,
              color: primaryDarkAccent,
              fontWeight: FontWeight.w700
            ),
          ),
          Text(
            '3/8 items completed',
            style: TextStyle(
              color: primaryDarkAccent,
              fontWeight: FontWeight.w500
            ),
          )
        ]
      ),
    );
  }
}
