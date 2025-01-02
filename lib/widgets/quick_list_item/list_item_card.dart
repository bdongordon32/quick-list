import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/widgets/text_input.dart';

class ListItemCard extends StatelessWidget {
  const ListItemCard(this.listItem, { super.key });

  final QuickListItem listItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: null),
        Flexible(
          child: Text(listItem.description, overflow: TextOverflow.clip)
        )
      ]
    );
  }
}
