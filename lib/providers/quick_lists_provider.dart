import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';

// ignore: non_constant_identifier_names
Map<String, String> CREATED_AT_SORT_MODES = {
  'descending': 'descending',
  'ascending':  'ascending'
};

class QuickListsProvider extends ChangeNotifier {

  final List<QuickList> _lists = [];

  bool isSortedByCreation = true;

  UnmodifiableListView<QuickList> get quickLists {
    return UnmodifiableListView(_lists);
  }

  void toggleSort(String sortMode) {
    if (sortMode == 'descending') {
      _lists.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      _lists.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    notifyListeners();
  }

  void setInitialList(List<QuickList> lists) {
    for (QuickList list in lists) {
      addList(list);
    }
  }

  void addList(QuickList list, { bool notify = true }) {
    _lists.add(list);

    notifyListeners();
  }

}
