import 'package:flutter/material.dart';
class ThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2ca8e2);
  static Color darkAccent = Color(0xff2ca8e2);
  static Color lightBG = Colors.white;
  static Color darkBG = Color(0xff121212);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );
}

// final darkTheme = ThemeData(
//   primarySwatch: Colors.grey,
//   primaryColor: Colors.black,
//   brightness: Brightness.dark,
//   backgroundColor: const Color(0xFF212121),
//   accentColor: Colors.white,
//   accentIconTheme: IconThemeData(color: Colors.black),
//   dividerColor: Colors.black12
// );

// final lightTheme = ThemeData(
//   primarySwatch: Colors.grey,
//   primaryColor: Colors.white,
//   brightness: Brightness.light,
//   backgroundColor: const Color(0xFFE5E5E5),
//   accentColor: Colors.black,
//   accentIconTheme: IconThemeData(color: Colors.white),
//   dividerColor: Colors.white54
// );