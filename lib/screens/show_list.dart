import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/widgets/quick_list_item/list_items_container.dart';
import 'package:quick_list/widgets/text_input.dart';

class ShowList extends StatefulWidget {
  const ShowList(this.quickList, {super.key});

  final QuickList quickList;

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  bool isTitleChanged = false;

  final titleFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    titleFieldController.text = widget.quickList.title;
    titleFieldController.text = widget.quickList.title;
  }

  @override
  Widget build(BuildContext context) {
    QuickList list = widget.quickList;
    int listItemsCount = list.listItems?.length ?? 0;
    int completedListItemsCount = list.listItems!.where((item) => item.completed).length;
    final String listTitle = list.title;

    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.quickList.title),
        title: Row(
          children: [
            // Text(widget.quickList.title),
            Expanded(
              child: TextInput(
                label: 'Title',
                defaultValue: 'Hleoo',
                inputController: titleFieldController,
                textStyle: TextStyle(color: primaryLightAccent),
                labelStyle: TextStyle(color: appBarLabelColor),
                onChanged: () {
                  setState(() {
                    isTitleChanged = true;
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.edit)
            ),
          ],
        ),
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
