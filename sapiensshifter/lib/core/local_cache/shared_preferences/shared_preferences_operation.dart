import 'package:sapiensshifter/core/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/core/exceptions/generic_exception/is_not_initialized_exception.dart';
import 'package:sapiensshifter/core/exceptions/local_cache_exceptions/index.dart';
import 'package:sapiensshifter/core/interface/operation_interface/local_cache_operation_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesOperation extends LocalCacheOperationInterface {
  SharedPreferencesOperation._();

  static final SharedPreferencesOperation _instance =
      SharedPreferencesOperation._();
  static SharedPreferencesOperation get instance => _instance;

  late final SharedPreferences? _pref;

  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  void _checkInitialization() {
    if (_pref == null) {
      throw IsNotInitializedException(
        instanceName: 'SharedPreferencesOperation',
      );
    }
  }

  Future<bool> _performWrite(String key, dynamic value) async {
    _checkInitialization();
    final operations = {
      String: () => _pref!.setString(key, value as String),
      bool: () => _pref!.setBool(key, value as bool),
      int: () => _pref!.setInt(key, value as int),
      double: () => _pref!.setDouble(key, value as double),
      List<String>: () => _pref!.setStringList(key, value as List<String>),
    };

    final operation = operations[value.runtimeType];
    if (operation != null) {
      return handleAsyncOperation(operation);
    } else {
      throw UnSupportedValueTypeException(value.runtimeType.toString());
    }
  }

  @override
  Future<bool> write<T>({required String key, required T value}) {
    return _performWrite(key, value);
  }

  @override
  Future<bool> writeAll({required Map<String, dynamic> items}) async {
    for (final entry in items.entries) {
      await _performWrite(entry.key, entry.value);
    }
    return true;
  }

  @override
  Future<MapEntry<String, T>> getValue<T>({required String key}) async {
    _checkInitialization();
    final value = _pref!.get(key);

    if (value is T) {
      return MapEntry(key, value);
    } else if (value == null) {
      throw KeyNotFoundException(key);
    } else {
      throw ValueTypeMismatchException(
        key,
        T.toString(),
        value.runtimeType.toString(),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getAllValue() async {
    _checkInitialization();
    return handleAsyncOperation(() async {
      return Map.fromEntries(
        _pref!.getKeys().map((key) {
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
    _checkInitialization();
    if (!_pref!.containsKey(key)) {
      throw KeyNotFoundException(key);
    }
    return _performWrite(key, newValue);
  }

  @override
  Future<bool> delete({required String key}) async {
    _checkInitialization();
    if (!_pref!.containsKey(key)) {
      throw KeyNotFoundException(key);
    }
    return handleAsyncOperation(() => _pref.remove(key));
  }
}
