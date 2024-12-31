import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/widgets/text_input.dart';

class ListItemCard extends StatefulWidget {
  const ListItemCard(this.listItem, {super.key, required this.callback});

  final QuickListItem listItem;
  final Function() callback;

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  bool isCompleted = false;
  
  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  void _toggleCompletion({
    required String quickListId,
    required String listItemId,
    required bool value
  }) {
    fireDb.collection('lists').doc(quickListId)
      .collection('list-items').doc(listItemId)
      .set({ 'completed': value }, SetOptions(merge: true))
      .then((onValue) => widget.callback());
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isCompleted = widget.listItem.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    String listItemId = widget.listItem.id;
    String quickListId = widget.listItem.quickListId;

    return Row(
      children: [
        Checkbox(
          value: isCompleted,
          onChanged: (bool? isChanged) {
            if (isChanged!) {
              setState(() {
                isCompleted = true;
              });
              _toggleCompletion(quickListId: quickListId, listItemId: listItemId, value: true);
            } else {
              setState(() {
                isCompleted = false;
              });
              _toggleCompletion(quickListId: quickListId, listItemId: listItemId, value: false);
            }
          }
        ),
        Flexible(
          child: Text(widget.listItem.description, overflow: TextOverflow.clip)
        )
      ]
    );
  }
}

// class ListItemCard extends StatelessWidget {
  // const ListItemCard(this.listItem, { super.key });

  // final QuickListItem listItem;
  

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     children: [
  //       Checkbox(value: false, onChanged: null),
  //       Text(listItem.description)
  //     ]
  //   );
  // }
// }
