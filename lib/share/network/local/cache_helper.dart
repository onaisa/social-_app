import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/models/usermodel.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    String key,
    bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool> removedata({String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Object getData({
    String key,
  }) async {
    return sharedPreferences.get(key);
  }

  static dynamic getBolean({
    String key,
  }) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  static Future<bool> saveUser({Object usermodel}) async {
    sharedPreferences.setString("usermodel", jsonDecode(usermodel));
  }

  static Future<bool> savedata({
    String key,
    dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int)
      return await sharedPreferences.setInt(key, value);
    else
      return await sharedPreferences.setBool(key, value);
  }
}
