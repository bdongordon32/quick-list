import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';

class QuickListsProvider extends ChangeNotifier {

  final List<QuickList> _lists = [];

  bool isSortedByCreation = true;

  UnmodifiableListView<QuickList> get quickLists {
    return UnmodifiableListView(_lists);
  }

  void addList(QuickList list) {
    _lists.add(list);
    notifyListeners();
  }

  void removeList(QuickList list) {
    _lists.remove(list);
    notifyListeners();
  }

  void toggleSort(String sortMode) {
    if (sortMode == 'descending') {
      _lists.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      _lists.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  }
}
