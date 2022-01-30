import 'package:flutter/material.dart';

class AppThemeState extends ChangeNotifier {
  bool isDarkModeEnabled = true;

  void setLightTheme() {
    isDarkModeEnabled = false;
    notifyListeners();
  }

  void setDarkTheme() {
    isDarkModeEnabled = true;
    notifyListeners();
  }
}
