import 'package:cloud_firestore/cloud_firestore.dart';

class QuickListItem {
  final String description;
  final bool? completed;

  const QuickListItem({
    this.description = '',
    this.completed = false
  });

  factory QuickListItem.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return QuickListItem(
      description: data?['description'],
      completed: data?['completed']
    );
  }
}
