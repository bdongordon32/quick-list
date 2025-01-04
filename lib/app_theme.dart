import 'package:flutter/material.dart';

final Color primaryDarkAccent = Color(0xFF5D6B85);
final Color primaryLightAccent = Color(0xFFE8EEFF);

final Color appBarLabelColor = Color.fromARGB(255, 176, 194, 244);

final Color deleteButtonColor = Color.fromARGB(255, 151, 73, 73);
final Color saveButtonColor = Color.fromARGB(255, 73, 151, 79);

final Color progressBarBase = Color.fromARGB(255, 183, 191, 206);
final Color progressBarCompleted = Color(0xFF5D6B85);

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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDarkAccent,
        textStyle: TextStyle(
          color:  primaryLightAccent,
        )
      )
    )
  );
}
