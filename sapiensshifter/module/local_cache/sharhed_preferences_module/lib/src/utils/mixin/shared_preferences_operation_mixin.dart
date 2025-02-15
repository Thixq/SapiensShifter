// This file is a part of the shared_preferences_operation.dart module.
part of '../../shared_preferences_operation.dart';

/// A mixin class providing a helper method to perform write operations
/// on SharedPreferences based on the type of the value.
mixin class SharedPreferencesOperationMixin {
  /// Writes a value to SharedPreferences under the given [key].
  ///
  /// The method checks the type of [value] and selects the corresponding
  /// write function from the [operations] map.
  /// If the value type is supported, it performs the write operation asynchronously.
  /// If not, it throws a ModuleSharedPreferencesException.
  Future<bool> _performWrite(
      String key, dynamic value, SharedPreferences pref) async {
    // Define a mapping between data types and their corresponding
    // SharedPreferences write methods.
    final operations = {
      String: () =>
          pref.setString(key, value as String), // Write String values.
      bool: () => pref.setBool(key, value as bool), // Write bool values.
      int: () => pref.setInt(key, value as int), // Write int values.
      double: () =>
          pref.setDouble(key, value as double), // Write double values.
      List<String>: () => pref.setStringList(
          key, value as List<String>), // Write List<String> values.
    };

    // Retrieve the appropriate operation based on the runtime type of [value].
    final operation = operations[value.runtimeType];

    if (operation != null) {
      // Execute the operation using a helper to handle asynchronous execution.
      return handleAsyncOperation(operation);
    } else {
      // If the type is not supported, throw an exception with details.
      throw ModuleSharedPreferencesException('un_supported_value',
          optionArgs: {'valueType': value.runtimeType.toString()});
    }
  }
}
