import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_list/models/quick_list_item.dart';

class QuickList {
  final String title;
  final String rawContent;
  final List<dynamic>? listItems;

  const QuickList({
    this.title = '',
    this.rawContent = '',
    this.listItems
  });

  factory QuickList.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return QuickList(
      title: data?['title'],
      rawContent: data?['rawContent'],
      listItems: data?['listItems']
    );
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
