import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.label,
    this.isRequired = false,
    this.inputController,
    super.key
  });

  final String label;
  final bool isRequired;
  final TextEditingController? inputController;

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
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
            color: primaryDarkAccent,
          ),
          child: Text(
            label,
            style: TextStyle(color: primaryLightAccent, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ),
      validator: (value) => validateInput(value),
    );
  }
}
