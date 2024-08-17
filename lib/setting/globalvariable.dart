import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider with ChangeNotifier {
  Color backgroundlevel1 = const Color.fromARGB(255, 243, 243, 243);
  Color backgroundlevel2 = const Color.fromARGB(255, 230, 228, 228);
  Color backgroundlevel3 = const Color.fromARGB(255, 150, 150, 150);
  Color themelevel1 = Color.fromARGB(255, 209, 10, 3);
  Color themelevel1trans = Color.fromARGB(22, 6, 157, 216);

  Color textcolor = const Color.fromARGB(255, 0, 0, 0);
  String nextthemestate = "dark mode";
  IconData nextthemeicon = Icons.dark_mode;
  Color nextthemeiconcolor = Colors.amber;
  final String themeKey = 'theme_mode';
  final String themeColorKey = 'theme_level1_color';
  Color _getBackgroundColor1(bool isDarkMode) => isDarkMode
      ? const Color.fromARGB(255, 10, 10, 10)
      : const Color.fromARGB(255, 243, 243, 243);

  Color _getBackgroundColor2(bool isDarkMode) => isDarkMode
      ? const Color.fromARGB(255, 41, 41, 41)
      : const Color.fromARGB(255, 230, 228, 228);

  Color _getBackgroundColor3(bool isDarkMode) => isDarkMode
      ? const Color.fromARGB(255, 109, 109, 109)
      : const Color.fromARGB(255, 150, 150, 150);

  // Color _getThemeLevel1(bool isDarkMode) => isDarkMode
  //     ? const Color.fromARGB(225, 138, 1, 138)
  //     : const Color.fromARGB(255, 243, 2, 243);

  Color _getTextColor(bool isDarkMode) => isDarkMode
      ? const Color.fromARGB(255, 224, 224, 224)
      : const Color.fromARGB(255, 0, 0, 0);

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(themeKey) ?? false;
    String? themeColorStr = prefs.getString(themeColorKey);
    if (themeColorStr != null) {
      themelevel1 = _colorFromString(themeColorStr);
    } else {
      //  themelevel1 = _getThemeLevel1(isDarkMode);
    }
    _updateColors(isDarkMode);
  }

  void _updateColors(bool isDarkMode) {
    backgroundlevel1 = _getBackgroundColor1(isDarkMode);
    backgroundlevel2 = _getBackgroundColor2(isDarkMode);
    backgroundlevel3 = _getBackgroundColor3(isDarkMode);
    //themelevel1 = _getThemeLevel1(isDarkMode);
    textcolor = _getTextColor(isDarkMode);
    nextthemestate = isDarkMode ? "light mode" : "dark mode";
    nextthemeicon = isDarkMode ? Icons.light_mode : Icons.dark_mode;
    nextthemeiconcolor = isDarkMode ? Colors.amber : Colors.black;
  }

  Future<void> changetheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(themeKey) ?? false;
    isDarkMode = !isDarkMode;
    await prefs.setBool(themeKey, isDarkMode);
    _updateColors(isDarkMode);
    notifyListeners();
  }

  // New function to set themeLevel1 to a specific color and save it in SharedPreferences
  Future<void> setThemeLevel1Color(Color newColor) async {
    themelevel1 = newColor;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeColorKey, _colorToString(newColor));
  }

  // Helper function to convert Color to String
  String _colorToString(Color color) {
    return '${color.alpha},${color.red},${color.green},${color.blue}';
  }

  // Helper function to convert String to Color
  Color _colorFromString(String colorString) {
    List<String> values = colorString.split(',');
    return Color.fromARGB(
      int.parse(values[0]),
      int.parse(values[1]),
      int.parse(values[2]),
      int.parse(values[3]),
    );
  }
}
