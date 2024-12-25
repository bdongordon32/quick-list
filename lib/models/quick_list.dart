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

  void completedSubtitle() {
    if (listItems!.isEmpty) { return; }

    for (var item in listItems!) {
      item.get()
        .then((DocumentSnapshot snapshot) {
          print(snapshot);
        });
    }
  }
}
