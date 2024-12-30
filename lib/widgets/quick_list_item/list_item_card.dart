import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/widgets/text_input.dart';

class ListItemCard extends StatefulWidget {
  const ListItemCard(this.listItem, {super.key});

  final QuickListItem listItem;

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isCompleted = widget.listItem.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Make API call to update the item list AFTER the state is set (no need to make the async request right now)
    return Row(
      children: [
        Checkbox(
          value: isCompleted,
          onChanged: (bool? isChanged) {
            if (isChanged!) {
              setState(() {
                isCompleted = true;
              });
            } else {
              setState(() {
                isCompleted = false;
              });
            }
          }
        ),
        Text(widget.listItem.description)
      ]
    );
  }
}

// class ListItemCard extends StatelessWidget {
  // const ListItemCard(this.listItem, { super.key });

  // final QuickListItem listItem;
  

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     children: [
  //       Checkbox(value: false, onChanged: null),
  //       Text(listItem.description)
  //     ]
  //   );
  // }
// }
