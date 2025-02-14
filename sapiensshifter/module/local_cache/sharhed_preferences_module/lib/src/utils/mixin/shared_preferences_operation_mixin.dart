part of '../../shared_preferences_operation.dart';

mixin class SharedPreferencesOperationMixin {
  Future<bool> _performWrite(
      String key, dynamic value, SharedPreferences pref) async {
    final operations = {
      String: () => pref.setString(key, value as String),
      bool: () => pref.setBool(key, value as bool),
      int: () => pref.setInt(key, value as int),
      double: () => pref.setDouble(key, value as double),
      List<String>: () => pref.setStringList(key, value as List<String>),
    };

    final operation = operations[value.runtimeType];
    if (operation != null) {
      return handleAsyncOperation(operation);
    } else {
      throw ModuleSharedPreferencesException('un_supported_value',
          optionArgs: {'valueType': value.runtimeType});
    }
  }
}
