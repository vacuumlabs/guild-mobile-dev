import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const _preferenceKey = "pref_key_theme";

  removeTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_preferenceKey);
  }

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_preferenceKey, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_preferenceKey);
  }
}
