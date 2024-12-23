import 'package:cloud_firestore/cloud_firestore.dart';

class QuickList {
  final String title;
  final String rawContent;

  const QuickList({
    this.title = '',
    this.rawContent = ''
  });

  factory QuickList.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return QuickList(
      title: data?['title'],
      rawContent: data?['rawContent']
    );
  }
}
