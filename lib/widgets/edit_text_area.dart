import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_list/models/quick_list.dart';
import 'package:quick_list/widgets/text_input.dart';

class EditTextArea extends StatelessWidget {
  EditTextArea({super.key, required this.quickList});

  final QuickList quickList;

  final _formKey = GlobalKey<FormState>();
  final listItemsTextController = TextEditingController();
  final FirebaseFirestore fireDb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    listItemsTextController.text = quickList.rawContent;

    return Form(
      key: _formKey,
      child: TextInput(
        label: 'Content',
        isRequired: true,
        inputController: listItemsTextController,
        minNoOfLines: 1,
        maxNoOfLines: 100,
        hintText: 'Paste a body of text and it will create a list automatically for you. (Max of 100 items)'
      ),
    );
  }
}
