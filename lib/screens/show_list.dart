
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';

class ShowList extends StatelessWidget {
  // const ShowList(this.quickList, {super.key});
  const ShowList(this.quickList, {super.key});

  final QuickList quickList;

  @override
  Widget build(BuildContext context) {
    int listItemsCount = quickList.listItems?.length ?? 0;
    int completedListItems = quickList.listItems!.where((item) => item.completed).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(quickList.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            LinearProgressBar(
              maxSteps: listItemsCount,
              currentStep: completedListItems,
              backgroundColor: progressBarBase,
              progressColor: progressBarCompleted,
            ),
            Text('Hello'),
          ],
        ),
      )
    );
  }
}
