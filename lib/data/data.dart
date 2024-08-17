import 'package:shared_preferences/shared_preferences.dart';

class AppCounter {
  static const _keyAppOpenCount = 'app_open_count';

  // Initialize shared preferences
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Get the current app open count
  static Future<int> getAppOpenCount() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyAppOpenCount) ?? 0;
  }

  // Increment the app open count
  static Future<void> incrementAppOpenCount() async {
    final prefs = await _getPrefs();
    final currentCount = await getAppOpenCount();
    await prefs.setInt(_keyAppOpenCount, currentCount + 1);
  }

//! ------------------------------ hadeel
  static const _keyHadeelCount = 'hadeel_count';

  // Initialize shared preferences
  //? no reasone u can use the same apove

  // Get the current app open count
  static Future<int> getHadeelCount() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyHadeelCount) ?? 0;
  }

  // Increment the app open count
  static Future<void> incrementHadeelCount() async {
    final prefs = await _getPrefs();
    final currentCount = await getAppOpenCount();
    await prefs.setInt(_keyHadeelCount, currentCount + 1);
  }

  //! ------------------------------ birthday
  static const _keyBirthdayCount = 'birthday_count';

  // Initialize shared preferences
  //? no reasone u can use the same apove

  // Get the current app open count
  static Future<int> getBirthdayCount() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_keyBirthdayCount) ?? 0;
  }

  // Increment the app open count
  static Future<void> incrementBirthdayCount() async {
    final prefs = await _getPrefs();
    final currentCount = await getAppOpenCount();
    await prefs.setInt(_keyBirthdayCount, currentCount + 1);
  }
}
