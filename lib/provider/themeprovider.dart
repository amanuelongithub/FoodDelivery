import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(33, 33, 33, 1),
      primaryColor: Color.fromRGBO(33, 33, 33, 1),
      fontFamily: "HandoSoft",
      iconTheme: const IconThemeData(color: Colors.black),
      colorScheme: const ColorScheme.dark());

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 231, 231, 231),
      primaryColor: Color.fromARGB(241, 239, 238, 238),
      fontFamily: "HandoSoft",
      iconTheme: const IconThemeData(color: Colors.white),
      colorScheme: const ColorScheme.light());
}
