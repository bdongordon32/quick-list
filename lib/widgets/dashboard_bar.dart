import 'package:flutter/material.dart';

class DashboardBar extends StatelessWidget {
  const DashboardBar({ super.key, required this.sortMode });

  final String sortMode;

  @override
  Widget build(BuildContext context) {
    final IconData sortIcon = sortMode == 'descending' ?
      Icons.arrow_downward_sharp :
      Icons.arrow_upward_sharp;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            side: BorderSide(
              style: BorderStyle.none,
            )
          ),
          onPressed: () {
            print('Change sort');
          },
          child: Row(
            children: [
              Text('Created By'),
              Padding(padding: EdgeInsets.only(left: 2, right: 2)),
              Icon(sortIcon)
            ],
          )
        )
      ],
    );
  }
}
