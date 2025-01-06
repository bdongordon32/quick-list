import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/providers/quick_list_items_provider.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/screens/show_list.dart';

class ListCard extends StatelessWidget {
  const ListCard(this.quickList, { super.key });

  final QuickList quickList;

  @override
  Widget build(BuildContext context) {
    final DateTime createdAtDate = quickList.createdAt.toDate();
    final String createdAtLabel = DateFormat('MMM dd, yy hh:mm').format(createdAtDate);

    return TextButton(
      onLongPress: () {
        print('Waybe');
      },
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowList(quickList)),
        );
      },
      child: Container(
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
            Consumer<QuickListsProvider>(
              builder: (context, listsProvider, child) {
                String subtitle = listsProvider.cardSubtitle(quickList);

                return Text(
                  subtitle,
                  style: TextStyle(
                    color: primaryDarkAccent,
                    fontWeight: FontWeight.w500
                  ),
                );
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  createdAtLabel,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ]
        ),
      )
    );
  }
}
