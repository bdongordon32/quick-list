import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list_item.dart';

class QuickListItemsProvider extends ChangeNotifier {
  final List<QuickListItem> _listItems = [];

  UnmodifiableListView<QuickListItem> get listItems {
    return UnmodifiableListView(_listItems);
  }

  void initListItems(List<QuickListItem>? items) {
    if (items!.isEmpty) return;

    for (QuickListItem item in items) {
      _listItems.add(item);
    }
  }

  void markAsCompleted(listItemId) {
    QuickListItem selectedListItem = _listItems.firstWhere((element) {
      return element.id == listItemId;
    });

    selectedListItem.completed = true;
    notifyListeners();
  }
}
