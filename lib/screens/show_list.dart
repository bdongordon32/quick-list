import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_list_items_provider.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/widgets/quick_list_item/list_item_card.dart';
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
  final listTextFieldController = TextEditingController();

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    titleFieldController.text = widget.quickList.title;

    if (widget.quickList.listItems!.isNotEmpty) {
      Provider.of<QuickListItemsProvider>(
        context,
        listen: false
      ).initListItems(widget.quickList.listItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    QuickList list = widget.quickList;
    final String listId = list.id;

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
        title: Row(
          children: [
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
            TextButton(
              style: TextButton.styleFrom(iconColor: deleteButtonColor),
              onPressed: () {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hold down to delete'), duration: Duration(milliseconds: 800))
                  );
                }
              },
              onLongPress: () {
                fireDb.collection('lists').doc(widget.quickList.id).delete()
                  .then((res) {
                    if (context.mounted) {
                      Provider.of<QuickListsProvider>(
                        context,
                        listen: false
                      ).removeList(widget.quickList);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Successfully deleted list'), duration: Duration(milliseconds: 800))
                      );
                      Navigator.of(context).pop();
                    }
                });
              },
              child: Icon(Icons.delete, size: 24,),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Consumer<QuickListItemsProvider>(
          builder: (context, itemProvider, child) {
            List<QuickListItem> listItems = itemProvider.listItems;
            int listItemsCount = listItems.length ?? 0;
            int completedListItemsCount = listItems.where((item) => item.completed).length;

            return Column(
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
                // ListItemsContainer(listItems)
                Expanded(
                  child: listItems.isEmpty ?
                  Text('No List items') :
                  ListView.builder(
                    itemCount: listItems.length,
                    itemBuilder: (BuildContext context, int index) => ListItemCard(listItems[index], quickList: list),
                  ),
                ),
              ],
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2)
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: Wrap(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    TextInput(
                      label: 'Content',
                      isRequired: true,
                      inputController: listTextFieldController,
                      minNoOfLines: 1,
                      maxNoOfLines: 10,
                      hintText: 'Paste a body of text and it will create a list automatically for you. (Max of 100 items)'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            print(listTextFieldController.text);
                          },
                          icon: Icon(Icons.check)
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel)
                        ),
                      ],
                    )
                  ],
                )
              );
            }
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
