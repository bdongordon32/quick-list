import 'package:cloud_firestore/cloud_firestore.dart';

class QuickListItem {
  final String id;
  String description;
  bool completed;

  // TODO: add getters/setters

  // String _description;
  // String get description => _description;
  // set description(String value) {
  //  _description = value;
  // }

  QuickListItem({
    required this.description,
    this.id = '',
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
