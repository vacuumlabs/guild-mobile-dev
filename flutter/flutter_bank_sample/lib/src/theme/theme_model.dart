import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/theme/theme_preference.dart';

class ThemeModel extends ChangeNotifier {
  bool? _isDark;
  final ThemePreferences _preferences;

  bool? get isDark => _isDark;

  ThemeModel()
      : _isDark = null,
        _preferences = ThemePreferences() {
    getPreferences();
  }

  set isDark(bool? value) {
    _isDark = value;
    if (value != null) {
      _preferences.setTheme(value);
    } else {
      _preferences.removeTheme();
    }
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
