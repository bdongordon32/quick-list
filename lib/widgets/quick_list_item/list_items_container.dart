import 'package:flutter/material.dart';
import 'package:quick_list/widgets/quick_list_item/list_item_card.dart';

class ListItemsContainer extends StatelessWidget {
  const ListItemsContainer(this.listItems, { super.key, required this.callback });

  final List<dynamic>? listItems;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    if (listItems!.isEmpty || listItems == null) {
      return Text('No list items');
    }

    return Expanded(
      child: ListView.builder(
        itemCount: listItems!.length,
        itemBuilder: (BuildContext context, int index) => ListItemCard(
          listItems![index],
          callback: callback,
        ),
      )
    );
  }
}
