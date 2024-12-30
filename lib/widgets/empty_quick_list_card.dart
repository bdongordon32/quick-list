import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';

class EmptyListCard extends StatelessWidget {
  const EmptyListCard({super.key});

  final String emptyText = 'No lists have been created. Click “+” below to add a new one';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryDarkAccent)
      ),
      child: Center(
        child: Text(emptyText),
      ),
    );
  }
}
