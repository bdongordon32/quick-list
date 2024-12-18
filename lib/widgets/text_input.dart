import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              color: primaryDarkAccent,
            ),
            child: Text(
              'Title',
              style: TextStyle(color: primaryLightAccent, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
