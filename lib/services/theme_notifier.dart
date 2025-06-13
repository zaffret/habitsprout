import 'package:flutter/material.dart';
import 'package:habit_sprout1/services/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  static const String themePreferenceKey = "theme_preference";
  bool _isDarkMode = false;

  ThemeNotifier() {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreference(_isDarkMode);
    notifyListeners();
  }

  void _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(themePreferenceKey) ?? false;
    notifyListeners();
  }

  void _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themePreferenceKey, isDarkMode);
  }
}
