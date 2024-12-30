import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/widgets/empty_quick_list_card.dart';
import 'package:quick_list/widgets/quick_list/list_card.dart';

class ListsContainer extends StatelessWidget {
  const ListsContainer(this.quickLists, { super.key, required this.callback });

  final List<QuickList> quickLists;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: quickLists.isEmpty ?
        EmptyListCard() :
        ListView.builder(
          itemCount: quickLists.length,
          itemBuilder: (BuildContext context, int index) => ListCard(quickLists[index], callback: callback),
        ),
    );
  }
}
