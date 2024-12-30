import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/widgets/quick_list_item/list_item_card.dart';

class ListItemsContainer extends StatelessWidget {
  const ListItemsContainer(this.listItems, { super.key });

  final List<dynamic>? listItems;

  @override
  Widget build(BuildContext context) {
    if (listItems!.isEmpty || listItems == null) {
      return Text('No list items');
    }

    // return Text('hello');
    return Expanded(
      child: ListView.separated(
        itemCount: listItems!.length,
        separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.all(4.0)),
          itemBuilder: (BuildContext context, int index) => ListItemCard(listItems![index]),
      )
    );
  }
}
