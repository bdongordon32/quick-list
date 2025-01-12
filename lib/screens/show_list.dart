import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/widgets/quick_list_item/add_form.dart';
import 'package:quick_list/widgets/quick_list_item/list_item_card.dart';
import 'package:quick_list/widgets/base_text_input.dart';

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
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Title has been saved'))
          );
          setState(() { isTitleChanged = false; });
          list.setTitle(titleFieldText);
          Provider.of<QuickListsProvider>(
            context,
            listen: false
          ).updateListTitle(list, titleFieldText);
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: BaseTextInput(
                label: 'Title',
                inputController: titleFieldController,
                textStyle: TextStyle(color: primaryLightAccent),
                labelStyle: TextStyle(color: appBarLabelColor),
                onChanged: () {
                  setState(() { isTitleChanged = true; });
                },
              ),
            ),
            Visibility(
              visible: isTitleChanged,
              maintainSize: false,
              child: IconButton(
                icon: const Icon(Icons.check),
                disabledColor: appBarLabelColor,
                onPressed: isTitleChanged ? saveTitle : null,
              ),
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
                  .then((_) {
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
        child: Consumer<QuickListsProvider>(
          builder: (context, listProvider, child) {
            List<QuickListItem> listItems = listProvider.quickListItems(listId);
            int listItemsCount = listItems.length;
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
            isScrollControlled: true,
            isDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2)
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                child: AddForm(
                  quickList: list,
                  bottomSheetContext: context,
                  fieldController: listTextFieldController
                ),
              );
            }
          );
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
