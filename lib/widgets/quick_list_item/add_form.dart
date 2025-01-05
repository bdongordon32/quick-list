import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_list_items_provider.dart';
import 'package:quick_list/widgets/text_input.dart';

class AddForm extends StatelessWidget {
  const AddForm({
    required this.bottomSheetContext,
    required this.fieldController,
    super.key
  });

  final BuildContext bottomSheetContext;
  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
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

                  // TODO: Call Firebase and add this to .then
                  Provider.of<QuickListItemsProvider>(
                    context,
                    listen: false
                  ).addListItems(items);
                  Navigator.of(bottomSheetContext).pop();
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