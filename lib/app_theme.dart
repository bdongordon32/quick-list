import 'package:flutter/material.dart';

final Color primaryDarkAccent = Color(0xFF5D6B85);
final Color primaryLightAccent = Color(0xFFE8EEFF);

class QuickListTheme {
  ThemeData appTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: primaryLightAccent,
    appBarTheme: AppBarTheme(
      color: Color(0xFF5D6B85),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0
      ),
      iconTheme: IconThemeData(color: Colors.white)
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5D6B85),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF5D6B85),
      brightness: Brightness.light,
    ),
  );
}
