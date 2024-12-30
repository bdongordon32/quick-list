import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/widgets/empty_quick_list_card.dart';
import 'package:quick_list/widgets/quick_list/quick_list_card.dart';

class QuickListContainer extends StatelessWidget {
  const QuickListContainer(this.quickLists, { super.key });

  final List<QuickList> quickLists;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: quickLists.isEmpty ?
        EmptyQuickListCard() :
        ListView.separated(
          itemCount: quickLists.length,
          separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.all(4.0)),
          itemBuilder: (BuildContext context, int index) => QuickListCard(quickLists[index]),
        ),
    );
  }
}
