import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/widgets/empty_quick_list_card.dart';
import 'package:quick_list/widgets/quick_list_card.dart';

class QuickListContainer extends StatelessWidget {
  const QuickListContainer(this.listItems, { super.key });

  final List<QuickList> listItems;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: listItems.isEmpty ?
        EmptyQuickListCard() :
        ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: listItems.length,
          separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.all(4.0)),
          itemBuilder: (BuildContext context, int index) => QuickListCard(listItems[index]),
        ),
    );
  }
}
