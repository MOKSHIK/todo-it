import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<dynamic> readCache({required String key}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // ignore: await_only_futures
    var cache = await sharedPreferences.getString(key);
    return cache;
  }

  Future<void> writeCache({required String key, required String value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  Future<void> deleteCache({required String key}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }
}
