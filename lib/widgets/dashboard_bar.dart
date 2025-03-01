import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';

class DashboardBar extends StatelessWidget {
  const DashboardBar({
    super.key,
    required this.sortMode,
    required this.onToggleSort,
    this.quickListCount = 0
  });

  final String sortMode;
  final Function()? onToggleSort;
  final int quickListCount;

  @override
  Widget build(BuildContext context) {
    final IconData sortIcon = sortMode == 'descending' ?
      Icons.arrow_downward_sharp :
      Icons.arrow_upward_sharp;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            // TODO: Fix padding to be global inside of container
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'List Count: $quickListCount',
              style: TextStyle(
                color: primaryDarkAccent,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
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
            onToggleSort!();
          },
          child: Row(
            children: [
              Text('Created By:'),
              Padding(padding: EdgeInsets.only(left: 2, right: 2)),
              Icon(sortIcon)
            ],
          )
        )
      ],
    );
  }
}
