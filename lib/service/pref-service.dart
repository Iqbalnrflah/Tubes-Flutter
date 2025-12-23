import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const String keyDarkMode = 'isDarkMode';
  static Future<void> setDarkMode(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDarkMode, isDark);
  }
  static Future<bool> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyDarkMode) ?? false;
  }
}
