import 'package:flutter/material.dart';
import 'package:quick_list/widgets/text_input.dart';

class ListItem extends StatelessWidget {
  const ListItem({ super.key });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Checkbox(value: false, onChanged: null),
      ]
    );
  }
}
