// shared_preferences_operation_test.dart

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:sharhed_preferences_module/src/excepiton/module_shared_preferences_exception.dart';
import 'package:sharhed_preferences_module/src/shared_preferences_operation.dart';
import 'init/localization_provider.dart';

@GenerateMocks([SharedPreferences])
import 'shared_preferences_operation_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferencesOperation spOperation;
  late MockSharedPreferences mockPref;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    LocalizationProvider.setInstance(TestLocalizationProvider());
    spOperation = SharedPreferencesOperation.instance;
    mockPref = MockSharedPreferences();

    // Test ortamı için _pref alanına mock örneğini atamak üzere oluşturduğunuz yardımcı metodu kullanın:
    await spOperation.setPrefForTest(Future.value(mockPref));
  });

  group('write', () {
    test(
        'String değeri yazarken doğru SharedPreferences metodunun çağrıldığını doğrular',
        () async {
      const key = 'testKey';
      const value = 'testValue';

      // _performWrite metodu içinde, String için setString çağrıldığını varsayıyoruz.
      when(mockPref.setString(key, value)).thenAnswer((_) async => true);

      final result = await spOperation.write<String>(key: key, value: value);
      expect(result, isTrue);

      verify(mockPref.setString(key, value)).called(1);
    });
  });

  group('getValue', () {
    test('Anahtar mevcutsa ve tip uyuyorsa doğru değeri döner', () async {
      const key = 'numberKey';
      const value = 42;

      when(mockPref.get(key)).thenReturn(value);

      final result = await spOperation.getValue<int>(key: key);
      expect(result.key, key);
      expect(result.value, value);
    });

    test('Anahtar bulunamazsa "not_found_key" exception fırlatır', () async {
      const key = 'nonexistentKey';

      when(mockPref.get(key)).thenReturn(null);

      expect(
        () async => await spOperation.getValue<int>(key: key),
        throwsA(isA<ModuleSharedPreferencesException>().having(
          (e) => e.message,
          'message',
          contains('not_found_key'),
        )),
      );
    });

    test('Tip uyuşmazlığı varsa "expected_type" exception fırlatır', () async {
      const key = 'stringKey';
      const value = 'stringValue';

      when(mockPref.get(key)).thenReturn(value);

      expect(
        () async => await spOperation.getValue<int>(key: key),
        throwsA(isA<ModuleSharedPreferencesException>().having(
          (e) => e.message,
          'message',
          contains('expected_type'),
        )),
      );
    });
  });

  group('delete', () {
    test('Anahtar mevcutsa silme işlemi başarılı olur', () async {
      const key = 'deleteKey';

      when(mockPref.containsKey(key)).thenReturn(true);
      when(mockPref.remove(key)).thenAnswer((_) async => true);

      final result = await spOperation.delete(key: key);
      expect(result, isTrue);
      verify(mockPref.remove(key)).called(1);
    });

    test('Anahtar yoksa "not_found_key" exception fırlatır', () async {
      const key = 'nonexistentKey';

      when(mockPref.containsKey(key)).thenReturn(false);

      expect(
        () async => await spOperation.delete(key: key),
        throwsA(isA<ModuleSharedPreferencesException>().having(
          (e) => e.message,
          'message',
          contains('not_found_key'),
        )),
      );
    });
  });

  // Diğer metodlar (updateValue, writeAll, getAllValue) için benzer test senaryoları oluşturabilirsiniz.
}
