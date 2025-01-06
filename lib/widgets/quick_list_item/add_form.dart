import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/widgets/text_input.dart';

class AddForm extends StatelessWidget {
  AddForm({
    required this.bottomSheetContext,
    required this.fieldController,
    required this.quickList,
    super.key
  });

  final BuildContext bottomSheetContext;
  final TextEditingController fieldController;
  final QuickList quickList;

  final FirebaseFirestore fireDb   = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String listId = quickList.id;

    return Padding(
      padding: EdgeInsets.all(12),
      child: Wrap(
        clipBehavior: Clip.antiAlias,
        children: [
          TextInput(
            label: 'Content',
            isRequired: true,
            inputController: fieldController,
            minNoOfLines: 1,
            maxNoOfLines: 10,
            hintText: 'Paste a body of text and it will create a list automatically for you. (Max of 100 items)'
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  String textFieldContent = fieldController.text;
                  if (textFieldContent.isEmpty) return;

                  // TODO: Make this a method and use in NewList as well
                  List<String> parsedListItems = textFieldContent.split('\n');
                  Iterable<QuickListItem> items = parsedListItems.map((String item) {
                    return QuickListItem(description: item, completed: false);
                  });

                  fireDb.runTransaction((Transaction transaction) async {
                    for (QuickListItem item in items) {
                      fireDb.collection('lists').doc(listId)
                        .collection('list-items')
                        .add({'description': item.description, 'completed': false});
                    }
                  })
                  .then((_) {
                    fieldController.clear();
                    if (bottomSheetContext.mounted) {
                      Provider.of<QuickListsProvider>(
                        context,
                        listen: false
                      ).addItemsToList(quickList, items);
                      Navigator.of(bottomSheetContext).pop();
                    }
                  });
                },
                icon: Icon(Icons.check)
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(bottomSheetContext).pop();
                },
                icon: Icon(Icons.cancel)
              ),
            ],
          )
        ],
      )
    );
  }
}