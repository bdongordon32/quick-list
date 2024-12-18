import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.label,
    this.isRequired = false,
    this.inputController,
    this.minNoOfLines = 1,
    this.maxNoOfLines = 1,
    this.hintText,
    super.key
  });

  final String label;
  final bool isRequired;
  final int minNoOfLines;
  final int maxNoOfLines;
  final TextEditingController? inputController;
  final String? hintText;

  String? validateInput(value) {
    if ((value == null || value.isEmpty) && isRequired) {
      return 'Please fill out field';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      minLines: minNoOfLines,
      maxLines: maxNoOfLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText
      ),
      validator: (value) => validateInput(value),
    );
  }
}
