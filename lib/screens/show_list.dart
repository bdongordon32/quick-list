import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
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
  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    titleFieldController.text = widget.quickList.title;
  }

  @override
  Widget build(BuildContext context) {
    QuickList list = widget.quickList;
    int listItemsCount = list.listItems?.length ?? 0;
    int completedListItemsCount = list.listItems!.where((item) => item.completed).length;
    final String listId = list.id;

    List<dynamic>? listItems = list.listItems;

    void saveTitle() {
      final String titleFieldText = titleFieldController.text;

      fireDb.collection('lists').doc(listId)
        .set({ 'title': titleFieldText }, SetOptions(merge: true))
        .then((event) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Title has been saved'))
            );
            setState(() { isTitleChanged = false; });
            list.setTitle(titleFieldText);
          }
        });
    }

    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.quickList.title),
        title: Row(
          children: [
            // Text(widget.quickList.title),
            Expanded(
              child: TextInput(
                label: 'Title',
                inputController: titleFieldController,
                textStyle: TextStyle(color: primaryLightAccent),
                labelStyle: TextStyle(color: appBarLabelColor),
                onChanged: () {
                  setState(() { isTitleChanged = true; });
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check),
              disabledColor: appBarLabelColor,
              onPressed: isTitleChanged ? saveTitle : null,
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  disabledColor: appBarLabelColor,
                  onPressed: () {}
                ),
              ],
            )
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
            ListItemsContainer(listItems)
          ],
        ),
      )
    );
  }
}
