import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData({
    required String key,
    required bool value,
  }) async {
    return await preferences.setBool(key, value);
  }

  static bool? getData(String key) {
    return preferences.getBool(key);
  }
}
