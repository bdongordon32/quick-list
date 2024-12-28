import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_list/widgets/text_input.dart';

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

    if (textFieldContent.isEmpty) return;

    List<String> listItems = textFieldContent.split('\n');

    // listItems, title, rawContent
    Map<String, dynamic> newQuickList = {
      "title": titleController.text,
      "rawContent": textFieldContent,
    };

    fireDb.collection('lists')
      .add(newQuickList)
      .then((documentSnapshot) {
        for (var item in listItems) {
          documentSnapshot
          .collection('listItems')
          .add({
            "description": item,
            "completed": false
          });
        }
        // documentSnapshot.set({
        //   listItems 
        // });
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
              TextInput(
                label: 'Title',
                inputController: titleController,
                isRequired: true,
              ),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: TextInput(
                  label: 'Content',
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
