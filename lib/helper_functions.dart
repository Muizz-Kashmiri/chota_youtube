import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static void setIsLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", value);
  }

  static Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("login") ?? false;
  }

  static void clearLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setIsLoggedIn(false);
  }

  static void setIsDarkMode(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", value);
  }

  static Future<bool> getIsDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("darkMode") ?? false;
  }
}
