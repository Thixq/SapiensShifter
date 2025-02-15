// Import core functionalities, SharedPreferences package for local storage,
// a custom exception for shared preferences errors, and meta annotations.
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'excepiton/module_shared_preferences_exception.dart';
import 'package:meta/meta.dart';

// Include additional helper methods from the mixin.
part './utils/mixin/shared_preferences_operation_mixin.dart';

/// A singleton class that implements local cache operations using SharedPreferences.
final class SharedPreferencesOperation extends LocalCacheOperationInterface
    with SharedPreferencesOperationMixin {
  // Private constructor to enforce the singleton pattern.
  SharedPreferencesOperation._();

  // A single, private instance of SharedPreferencesOperation.
  static final SharedPreferencesOperation _instance =
      SharedPreferencesOperation._();

  // Public getter to access the singleton instance.
  static SharedPreferencesOperation get instance => _instance;

  // Late initialization of the SharedPreferences instance.
  late final SharedPreferences _pref;

  /// For testing purposes: sets the SharedPreferences instance with a provided Future.
  @visibleForTesting
  Future<void> setPrefForTest(Future<SharedPreferences> preferences) async {
    _pref = await preferences;
  }

  /// Initializes the SharedPreferences instance by obtaining it from the package.
  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  /// Writes a single key-value pair to SharedPreferences.
  /// Uses the helper method [_performWrite] (likely defined in the mixin).
  @override
  Future<bool> write<T>({required String key, required T value}) {
    return _performWrite(key, value, _pref);
  }

  /// Writes multiple key-value pairs to SharedPreferences.
  /// Iterates over each entry in [items] and writes them individually.
  @override
  Future<bool> writeAll({required Map<String, dynamic> items}) async {
    for (final entry in items.entries) {
      await _performWrite(entry.key, entry.value, _pref);
    }
    return true;
  }

  /// Retrieves a value for the given [key] and ensures it matches the expected type [T].
  /// - If the value is of type [T], it returns a MapEntry containing the key and value.
  /// - If the key doesn't exist, it throws a 'not_found_key' exception.
  /// - If the type doesn't match, it throws an 'expected_type' exception.
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

  /// Retrieves all key-value pairs stored in SharedPreferences.
  /// The result is wrapped in a handler to manage asynchronous operations.
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

  /// Updates the value for an existing key in SharedPreferences.
  /// Throws a 'not_found_key' exception if the key does not exist.
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

  /// Deletes the key-value pair associated with [key] from SharedPreferences.
  /// Throws a 'not_found_key' exception if the key is not found.
  @override
  Future<bool> delete({required String key}) async {
    if (!_pref.containsKey(key)) {
      throw ModuleSharedPreferencesException('not_found_key',
          optionArgs: {'key': key});
    }
    return handleAsyncOperation(() => _pref.remove(key));
  }
}
