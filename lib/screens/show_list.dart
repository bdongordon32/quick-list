import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/widgets/quick_list_item/list_items_container.dart';

class ShowList extends StatefulWidget {
  const ShowList(this.quickList, {super.key});

  final QuickList quickList;

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  // const ShowList(this.quickList, {super.key});

  @override
  Widget build(BuildContext context) {
    int listItemsCount = widget.quickList.listItems?.length ?? 0;
    int completedListItemsCount = widget.quickList.listItems!.where((item) => item.completed).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quickList.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            LinearProgressBar(
              maxSteps: listItemsCount,
              currentStep: completedListItemsCount,
              backgroundColor: progressBarBase,
              progressColor: progressBarCompleted,
              semanticsLabel: 'Hi',
              semanticsValue: 'Bye',
            ),
            Padding(padding: EdgeInsets.only(bottom: 8)),
            Text('$completedListItemsCount of $listItemsCount is completed'),
            ListItemsContainer()
          ],
        ),
      )
    );
  }
}
