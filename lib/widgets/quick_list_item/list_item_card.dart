import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/widgets/base_text_input.dart';
import 'package:flutter/services.dart';


// TODO: Error handling from fireDb
class ListItemCard extends StatefulWidget {
  const ListItemCard(
    this.listItem,
    { super.key, required this.quickList }
  );

  final QuickListItem listItem;
  final QuickList quickList;

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  bool isCompleted = false;
  bool isEditing = false;

  bool isDeletingItem = false;
  
  final FirebaseFirestore fireDb = FirebaseFirestore.instance;
  final TextEditingController descriptionController = TextEditingController();

  void _toggleCompletion({
    required String quickListId,
    required String listItemId,
    required bool value
  }) {
    fireDb.collection('lists').doc(quickListId)
      .collection('list-items').doc(listItemId)
      .set({ 'completed': value }, SetOptions(merge: true))
      .then((_) {
        if (!mounted) return;

        QuickListsProvider providerInstance = Provider.of<QuickListsProvider>(
          context,
          listen: false
        );

        if (value) {
          providerInstance.markItemAsComplete(widget.quickList, listItemId);
        } else {
          providerInstance.markItemAsInComplete(widget.quickList, listItemId);
        }
      });
  }

  void _deleteItem() {
    fireDb.collection('lists').doc(widget.quickList.id)
      .collection('list-items').doc(widget.listItem.id)
      .delete()
      .then((_) {
        if (!mounted) return;

        Provider.of<QuickListsProvider>(
          context,
          listen: false
        ).removeListItem(
          widget.listItem,
          listId: widget.quickList.id
        );

        setState(() => isDeletingItem = false);
      });
  }

  void _updateItemDescripton(String value) {
    fireDb.collection('lists').doc(widget.quickList.id)
      .collection('list-items').doc(widget.listItem.id)
      .set({ 'description': value }, SetOptions(merge: true))
      .then((_) {
        if (!mounted) return;

        Provider.of<QuickListsProvider>(
          context,
          listen: false
        ).updateListItem(
          widget.quickList,
          widget.listItem.id,
          description: value
        );
        setState(() => isEditing = false);
      });
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
    String quickListId = widget.quickList.id;

    descriptionController.text = widget.listItem.description;

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
          child: isEditing ?
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                BaseTextInput(
                  inputController: descriptionController,
                  inputAction: TextInputAction.go,
                  maxNoOfLines: 3,
                  onFieldSubmit: (String value) => _updateItemDescripton(value)
                ),
                IconButton(
                  iconSize: 18,
                  onPressed: () {
                    setState(() => isEditing = false);
                  },
                  icon: Icon(Icons.cancel)
                )
              ],
            ) :
            GestureDetector(
              onTap: () {
                setState(() => isEditing = true);
              },
              onLongPressUp: () {
                Clipboard.setData(
                  ClipboardData(
                    text: widget.listItem.description,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item description copied'), duration: Duration(milliseconds: 800))
                );
              },
              onPanUpdate: (DragUpdateDetails details) {
                if (details.delta.dx < -10) {
                  setState(() => isDeletingItem = true);
                } else if (details.delta.dx > 10) {
                  setState(() => isDeletingItem = false);
                }
                // _deleteItem();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.listItem.description,
                      overflow: TextOverflow.clip
                    ),
                  ),
                  Visibility(
                    maintainSize: false,
                    visible: isDeletingItem,
                    child: IconButton(
                      onPressed: () {
                        _deleteItem();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: deleteButtonColor,
                      )
                    )
                  )
                ],
              )
            )
        )
      ]
    );
  }
}
