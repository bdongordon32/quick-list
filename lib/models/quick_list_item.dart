import 'package:cloud_firestore/cloud_firestore.dart';

class QuickListItem {
  final String id;
  final String description;
  final bool completed;
  final String quickListId;

  const QuickListItem({
    required this.id,
    this.description = '',
    this.completed = false,
    required this.quickListId
  });

  factory QuickListItem.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> snapshot, { required String quickListId }) {
    final data = snapshot.data();

    return QuickListItem(
      id: snapshot.id,
      description: data?['description'],
      completed: data?['completed'],
      quickListId: quickListId
    );
  }
}
