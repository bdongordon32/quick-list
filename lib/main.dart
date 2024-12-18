import 'package:flutter/material.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/screens/dashboard.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: QuickListTheme().appTheme,
      home: Dashboard()
    );
  }
}
