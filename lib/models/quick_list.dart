import 'package:cloud_firestore/cloud_firestore.dart';

class QuickList {
  final String title;
  final String rawContent;
  List<dynamic>? listItems;

  QuickList({
    this.title = '',
    this.rawContent = '',
    this.listItems
  });

  factory QuickList.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return QuickList(
      title: data?['title'],
      rawContent: data?['rawContent'],
    );
  }

  void addToListItems(listItem) {
    listItems ??= [];
    listItems!.add(listItem);
  }

  String cardSubtitle() {
    if (listItems!.isEmpty) {
      return 'No items';
    }

    int completeItems = listItems!.where((item) => item.completed).length;
    int listCount = listItems!.length;

    return '$completeItems/$listCount items completed';
  }
}
