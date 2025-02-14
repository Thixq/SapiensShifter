import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'excepiton/module_shared_preferences_exception.dart';
import 'package:meta/meta.dart';

part './utils/mixin/shared_preferences_operation_mixin.dart';

final class SharedPreferencesOperation extends LocalCacheOperationInterface
    with SharedPreferencesOperationMixin {
  SharedPreferencesOperation._();

  static final SharedPreferencesOperation _instance =
      SharedPreferencesOperation._();
  static SharedPreferencesOperation get instance => _instance;

  late final SharedPreferences _pref;

  @visibleForTesting
  Future<void> setPrefForTest(Future<SharedPreferences> preferences) async {
    _pref = await preferences;
  }

  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> write<T>({required String key, required T value}) {
    return _performWrite(key, value, _pref);
  }

  @override
  Future<bool> writeAll({required Map<String, dynamic> items}) async {
    for (final entry in items.entries) {
      await _performWrite(entry.key, entry.value, _pref);
    }
    return true;
  }

  @override
  Future<MapEntry<String, T>> getValue<T>({required String key}) async {
    final value = _pref.get(key);

    if (value is T) {
      return MapEntry(key, value);
    } else if (value == null) {
      throw ModuleSharedPreferencesException('not_found_key',
          optionArgs: {'key': key});
    } else {
      throw ModuleSharedPreferencesException('expected_type', optionArgs: {
        'key': key,
        'expectedType': T.runtimeType,
        'actualType': value.runtimeType
      });
    }
  }

  @override
  Future<Map<String, dynamic>> getAllValue() async {
    return handleAsyncOperation(() async {
      return Map.fromEntries(
        _pref.getKeys().map((key) {
          final value = _pref.get(key);
          return MapEntry(key, value);
        }),
      );
    });
  }

  @override
  Future<bool> updateValue({
    required String key,
    required dynamic newValue,
  }) async {
    if (!(_pref.containsKey(key))) {
      throw ModuleSharedPreferencesException('not_found_key',
          optionArgs: {'key': key});
    }
    return _performWrite(key, newValue, _pref);
  }

  @override
  Future<bool> delete({required String key}) async {
    if (!_pref.containsKey(key)) {
      throw ModuleSharedPreferencesException('not_found_key',
          optionArgs: {'key': key});
    }
    return handleAsyncOperation(() => _pref.remove(key));
  }
}
