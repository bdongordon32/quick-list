import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.label,
    this.isRequired = false,
    this.inputController,
    this.minNoOfLines = 1,
    this.maxNoOfLines = 1,
    this.hintText,
    this.onChanged,
    this.defaultValue,
    this.textStyle,
    this.labelStyle,
    super.key
  });

  final String label;
  final bool isRequired;
  final int minNoOfLines;
  final int maxNoOfLines;
  final TextEditingController? inputController;
  final String? hintText;
  final Function()? onChanged;
  final String? defaultValue;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;

  String? validateInput(value) {
    if ((value == null || value.isEmpty) && isRequired) {
      return 'Please fill out field';
    }
    return null;
  }

  void handleOnChange(String value) {
    if (onChanged == null) { return; }

    onChanged!();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => handleOnChange(value),
      controller: inputController,
      minLines: minNoOfLines,
      maxLines: maxNoOfLines,
      decoration: InputDecoration(
        labelText: isRequired ? "$label (required)" : label,
        hintText: hintText,
        labelStyle: labelStyle
      ),
      style: textStyle,
      validator: (value) => validateInput(value),
    );
  }
}
