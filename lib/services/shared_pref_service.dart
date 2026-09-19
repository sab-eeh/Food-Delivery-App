import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String loginKey = "isLoggedIn";

  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, value);
  }

  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(loginKey) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(loginKey);
  }
}
