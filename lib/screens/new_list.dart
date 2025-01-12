import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/models/quick_list_item.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/widgets/base_text_input.dart';

class NewList extends StatefulWidget {
  const NewList({ super.key });

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  final _formKey = GlobalKey<FormState>();

  final listTextFieldController = TextEditingController();
  final titleController = TextEditingController();

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  void convertTextToList() {
    String textFieldContent = listTextFieldController.text;

    // TODO: Allow user to create list without items
    if (textFieldContent.isEmpty) return;

    List<String> parsedListItems = textFieldContent.split('\n');
    String title = titleController.text;

    Map<String, dynamic> newQuickList = {
      'title': title,
      'rawContent': textFieldContent,
      'createdAt': FieldValue.serverTimestamp()
    };

    List<QuickListItem> listItems = [];

    fireDb.collection('lists')
      .add(newQuickList)
      .then((DocumentReference<Map<String, dynamic>> documentReference) {
        fireDb.runTransaction((transaction) async {
          for (String description in parsedListItems) {
            QuickListItem item = QuickListItem(
              description: description,
              completed: false
            );

            documentReference
              .collection('list-items')
              .add({'description': item.description, 'completed': item.completed})
              .then((_) => listItems.add(item));
          }
        })
        .then((_) {
          documentReference.get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Quick list has been added'))
                );
                QuickList list = QuickList.fromSnapshot(snapshot);

                for (QuickListItem item in listItems) {
                  list.addToListItems(item);
                }

                Provider.of<QuickListsProvider>(context, listen: false).addList(list);
                Navigator.of(context).pop();
              }
            });
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New List'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseTextInput(
                label: 'Title',
                inputController: titleController,
                isRequired: true,
              ),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: BaseTextInput(
                  label: 'Content',
                  isRequired: true,
                  inputController: listTextFieldController,
                  minNoOfLines: 1,
                  maxNoOfLines: 100,
                  hintText: 'Paste a body of text and it will create a list automatically for you. (Max of 100 items)'
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      convertTextToList();
                    }
                  },
                  child: const Text('Create List', style: TextStyle(color: Colors.white),),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 8))
            ],
          ),
        )
      )
    );
  }
}
