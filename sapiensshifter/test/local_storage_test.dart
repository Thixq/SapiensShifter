import 'package:flutter_test/flutter_test.dart';
import 'package:sapiensshifter/feature/interface/i_service/i_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorageService implements ILocalStorageService {
  @override
  Future<void> write<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) as T?;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

void main() {
  group('SharedPreferencesLocalStorageService', () {
    late SharedPreferencesLocalStorageService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      service = SharedPreferencesLocalStorageService();
    });

    test('should save and read a string value', () async {
      await service.write('testKey', 'testValue');
      final value = await service.read<String>('testKey');
      expect(value, 'testValue');
    });

    test('should save and read an int value', () async {
      await service.write('intKey', 42);
      final value = await service.read<int>('intKey');
      expect(value, 42);
    });

    test('should save and read a double value', () async {
      await service.write('doubleKey', 3.14);
      final value = await service.read<double>('doubleKey');
      expect(value, 3.14);
    });

    test('should save and read a bool value', () async {
      await service.write('boolKey', true);
      final value = await service.read<bool>('boolKey');
      expect(value, true);
    });

    test('should save and read a List<String> value', () async {
      await service.write('listKey', ['one', 'two', 'three']);
      final value = await service.read<List<String>>('listKey');
      expect(value, ['one', 'two', 'three']);
    });

    test('should remove a value', () async {
      await service.write('removeKey', 'valueToRemove');
      await service.remove('removeKey');
      final value = await service.read<String>('removeKey');
      expect(value, null);
    });

    test('should clear all values', () async {
      await service.write('key1', 'value1');
      await service.write('key2', 'value2');
      await service.clear();
      final value1 = await service.read<String>('key1');
      final value2 = await service.read<String>('key2');
      expect(value1, null);
      expect(value2, null);
    });
  });
}
