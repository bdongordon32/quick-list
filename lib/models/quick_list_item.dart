import 'package:cloud_firestore/cloud_firestore.dart';

class QuickListItem {
  final String id;
  final String description;
  final bool completed;

  const QuickListItem({
    this.id = '',
    this.description = '',
    this.completed = false
  });

  factory QuickListItem.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return QuickListItem(
      id: snapshot.id,
      description: data?['description'],
      completed: data?['completed']
    );
  }
}
