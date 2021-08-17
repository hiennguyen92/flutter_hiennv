import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<bool> save<T>(String key, T value) async {
    // Get SharedPreferences
    SharedPreferences refs = await SharedPreferences.getInstance();

    if (value == null) {
      refs.remove(key);
      return true;
    }
    if (value is String) {
      return refs.setString(key, value);
    } else if (value is bool) {
      return refs.setBool(key, value);
    } else if (value is int) {
      return refs.setInt(key, value);
    } else if (value is double) {
      return refs.setDouble(key, value);
    } else if (value is List<String>) {
      return refs.setStringList(key, value);
    }
    return false;
  }

  // Get data by key
  Future<T> get<T>(String key) async {
    // Get SharedPreferences
    SharedPreferences refs = await SharedPreferences.getInstance();
    // Cast data type
    return refs.get(key) as T;
  }

  // Clear all
  Future<bool> clear() async {
    // Get SharedPreferences ref
    SharedPreferences ref = await SharedPreferences.getInstance();
    return ref.clear();
  }
}
