import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sapiensshifter/core/local_cache/shared_preferences/shared_preferences_operation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mocking SharedPreferences
@GenerateMocks([SharedPreferences])
import 'shared_preferences_operation_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSharedPreferences mockSharedPreferences;
  late SharedPreferencesOperation sharedPreferencesOperation;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockSharedPreferences = MockSharedPreferences();
    sharedPreferencesOperation = SharedPreferencesOperation.instance;
    await sharedPreferencesOperation.initialize();
    // The test is over, there is no need for the test anymore
    // sharedPreferencesOperation._pref = mockSharedPreferences;
  });

  group('SharedPreferencesOperation Tests', () {
    test('write should save a string', () async {
      const key = 'test_key';
      const value = 'test_value';

      when(mockSharedPreferences.setString(key, value))
          .thenAnswer((_) async => true);

      final result =
          await sharedPreferencesOperation.write(key: key, value: value);

      expect(result, true);
      verify(mockSharedPreferences.setString(key, value)).called(1);
    });

    test('write should throw for unsupported types', () async {
      const key = 'test_key';
      const value = Duration(seconds: 1);

      expect(
        () async => sharedPreferencesOperation.write(key: key, value: value),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('writeAll should save multiple key-value pairs', () async {
      final items = {'key1': 'value1', 'key2': 2};

      when(mockSharedPreferences.setString('key1', 'value1'))
          .thenAnswer((_) async => true);
      when(mockSharedPreferences.setInt('key2', 2))
          .thenAnswer((_) async => true);

      final result = await sharedPreferencesOperation.writeAll(items: items);

      expect(result, true);
      verify(mockSharedPreferences.setString('key1', 'value1')).called(1);
      verify(mockSharedPreferences.setInt('key2', 2)).called(1);
    });

    test('getValue should return the correct value for the key', () async {
      const key = 'test_key';
      const value = 'test_value';

      when(mockSharedPreferences.get(key)).thenReturn(value);

      final result =
          await sharedPreferencesOperation.getValue<String>(key: key);

      expect(result.key, key);
      expect(result.value, value);
    });

    test('getValue should throw if the key does not exist', () async {
      const key = 'missing_key';

      when(mockSharedPreferences.get(key)).thenReturn(null);

      expect(
        () async => sharedPreferencesOperation.getValue<String>(key: key),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('updateValue should update the value if the key exists', () async {
      const key = 'test_key';
      const newValue = 'new_value';

      when(mockSharedPreferences.containsKey(key)).thenReturn(true);
      when(mockSharedPreferences.setString(key, newValue))
          .thenAnswer((_) async => true);

      final result = await sharedPreferencesOperation.updateValue(
        key: key,
        newValue: newValue,
      );

      expect(result, true);
      verify(mockSharedPreferences.setString(key, newValue)).called(1);
    });

    test('updateValue should throw if the key does not exist', () async {
      const key = 'missing_key';
      const newValue = 'new_value';

      when(mockSharedPreferences.containsKey(key)).thenReturn(false);

      expect(
        () async => sharedPreferencesOperation.updateValue(
          key: key,
          newValue: newValue,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('delete should remove the key if it exists', () async {
      const key = 'test_key';

      when(mockSharedPreferences.containsKey(key)).thenReturn(true);
      when(mockSharedPreferences.remove(key)).thenAnswer((_) async => true);

      final result = await sharedPreferencesOperation.delete(key: key);

      expect(result, true);
      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('delete should throw if the key does not exist', () async {
      const key = 'missing_key';

      when(mockSharedPreferences.containsKey(key)).thenReturn(false);

      expect(
        () async => sharedPreferencesOperation.delete(key: key),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getAllValue should return all stored key-value pairs', () async {
      final allValues = {'key1': 'value1', 'key2': 2};

      when(mockSharedPreferences.getKeys()).thenReturn(allValues.keys.toSet());
      when(mockSharedPreferences.get('key1')).thenReturn(allValues['key1']);
      when(mockSharedPreferences.get('key2')).thenReturn(allValues['key2']);

      final result = await sharedPreferencesOperation.getAllValue();

      expect(result, allValues);
      verify(mockSharedPreferences.getKeys()).called(1);
      verify(mockSharedPreferences.get('key1')).called(1);
      verify(mockSharedPreferences.get('key2')).called(1);
    });
  });
}
