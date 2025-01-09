import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';

class QuickListsProvider extends ChangeNotifier {
  final List<QuickList> _lists = [];
  final String quickListId = '';

  final Map<String, List<QuickListItem>> _listItemsByListId = {};

  UnmodifiableListView<QuickList> get quickLists {
    return UnmodifiableListView(_lists);
  }

  UnmodifiableListView<QuickListItem> quickListItems(String listId) {
    if (_listItemsByListId[listId] == null) {
      return UnmodifiableListView([]);
    }

    return UnmodifiableListView(_listItemsByListId[listId]!);
  }

  void addList(QuickList list) {
    _lists.add(list);
    _initListItems(list, list.listItems);
    notifyListeners();
  }

  void removeList(QuickList list) {
    _lists.remove(list);
    _listItemsByListId.remove(list.id);
    notifyListeners();
  }

  void toggleSort(String sortMode) {
    if (sortMode == 'descending') {
      _lists.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      _lists.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  }

  // void addItemToList(QuickList list, QuickList)
  void addItemsToList(QuickList list, Iterable<QuickListItem> items) {
    if (items.isEmpty) return;

    String listId = list.id;
    if (_listItemsByListId[listId] == null) return;

    _listItemsByListId[listId]?.addAll((items));
    notifyListeners();
  }

  void markItemAsComplete(QuickList list, String listItemId) {
    String listId = list.id;
    _selectedListItem(listItemId, listId: listId).completed = true;
    notifyListeners();
  }

  void markItemAsInComplete(QuickList list, String listItemId) {
    String listId = list.id;
    _selectedListItem(listItemId, listId: listId).completed = false;
    notifyListeners();
  }

  String cardSubtitle(QuickList list) {
    String listId = list.id;
    List<QuickListItem> items = _listItemsByListId[listId]!;

    if (items.isEmpty) {
      return 'No items';
    }

    int completeItems = items.where((item) => item.completed).length;
    int listCount = items.length;

    return '$completeItems/$listCount items completed';
  }

  void updateListItem(QuickList list, String listItemId, { required String description }) {
    _selectedListItem(listItemId, listId: list.id).description = description;
    notifyListeners();
  }

  void removeListItem(QuickListItem item, { required String listId }) {
    _listItemsByListId[listId]!.remove(item);
    notifyListeners();
  }

  QuickListItem _selectedListItem(String listItemId, { required String listId }) {
    return _listItemsByListId[listId]
      !.firstWhere((QuickListItem element) => element.id == listItemId);
  }

  void _initListItems(QuickList list, List<QuickListItem>? listItems) {
    String listId = list.id;

    if (_listItemsByListId[listId] == null) {
      _listItemsByListId[listId] = [];
    }

    _listItemsByListId[listId]?.addAll(listItems!);
  }
}
