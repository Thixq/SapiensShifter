import 'package:sapiensshifter/feature/interface/i_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ILocalStorageService {
  factory SharedPreferencesService.instance() => _instance;

  SharedPreferencesService._internal() {
    _init();
  }

  late final SharedPreferences _prefs;

  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> write<T>(String key, T value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Bu veri türü desteklenmiyor.');
    }
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<T?>? read<T>(String key) {
    return _prefs.get(key)! as Future<T>;
  }
}
