import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static const _keyToken = 'token';
  static const _keyEmail = 'email';
  static const _keyUserId = 'userId';

  /// Initialize SharedPreferences once
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// token
  static Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  static String? getToken() {
    return _prefs.getString(_keyToken);
  }

  static Future<bool> isLoggedIn() async {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearToken() async {
    await _prefs.remove(_keyToken);
  }

  /// email
  static Future<void> saveEmail(String email) async {
    await _prefs.setString(_keyEmail, email);
  }

  static String? getEmail() {
    return _prefs.getString(_keyEmail);
  }

  /// userId
  static Future<void> saveUserId(String userId) async {
    await _prefs.setString(_keyUserId, userId);
  }

  static String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

  /// clear
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}