import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  ThemeProvider(this._themeData);

  getTheme() => _themeData;
  
  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}