import 'package:flutter/material.dart';

class SortBar extends StatelessWidget {
  const SortBar({ super.key, required this.sortMode });

  final String sortMode;

  @override
  Widget build(BuildContext context) {
    return Text('SortBar: $sortMode');
  }

}
