import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list_item.dart';

class QuickListItemsProvider extends ChangeNotifier {
  final List<QuickListItem> _listItems = [];

  UnmodifiableListView<QuickListItem> get listItems {
    return UnmodifiableListView(_listItems);
  }

  void initListItems(List<QuickListItem>? items) {
    if (items!.isEmpty) { return; }
    if (_listItems.isNotEmpty) { _listItems.clear(); }

    for (QuickListItem item in items) {
      _listItems.add(item);
    }
  }

  void markAsIncomplete(listItemId) {
    _selectedListItem(listItemId).completed = false;
    notifyListeners();
  }

  void markAsComplete(listItemId) {
    _selectedListItem(listItemId).completed = true;
    notifyListeners();
  }

  QuickListItem _selectedListItem(listItemId) {
    return _listItems.firstWhere((element) {
      return element.id == listItemId;
    });
  }

  void addListItems(Iterable<QuickListItem> items) {
    if (items.isEmpty) return;

    for (QuickListItem item in items) {
      _listItems.add(item);
    }

    notifyListeners();
  }
}
