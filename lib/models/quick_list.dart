import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_list/models/quick_list_item.dart';

class QuickList {
  final String id;
  String title;
  final String rawContent;
  final Timestamp createdAt;
  List<QuickListItem>? listItems;

  QuickList({
    required this.id,
    required this.title,
    required this.createdAt,
    this.rawContent = '',
    this.listItems
  });

  factory QuickList.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return QuickList(
      id:    snapshot.id,
      title: data?['title'],
      rawContent: data?['rawContent'],
      createdAt: data?['createdAt']
    );
  }

  void addToListItems(listItem) {
    listItems ??= [];
    listItems!.add(listItem);
  }

  void setTitle(listTitle) {
    title = listTitle;
  }

  String cardSubtitle() {
    if (listItems == null || listItems!.isEmpty) {
      return 'No items';
    }

    int completeItems = listItems!.where((item) => item.completed).length;
    int listCount = listItems!.length;

    return '$completeItems/$listCount items completed';
  }
}
