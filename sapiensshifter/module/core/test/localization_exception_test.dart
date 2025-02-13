import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  setUp(
    () {
      LocalizationProvider.setInstance(EasyLocalizationProvider());
    },
  );

  test(
    'localization exception test',
    () {
      try {
        throw OneException('errors', 'wrong_password');
      } catch (e) {
        print(e);
      }
    },
  );
}

class EasyLocalizationProvider implements LocalizationProvider {
  @override
  String getMessage(String key, {Map<String, dynamic>? optionArgs}) {
    // Burada basit bir çeviri haritası var, gerçek uygulamada dış kaynaklar veya API kullanılabilir
    final translations = {
      'errors.invalid_email': 'Geçersiz e-posta formatı.',
      'errors.user_disabled': 'Kullanıcı devre dışı bırakılmış.',
      'errors.user_not_found': 'Kullanıcı bulunamadı.',
      'errors.wrong_password': 'Yanlış şifre.',
    };
    return translations[key] ?? 'Bilinmeyen hata';
  }
}

class OneException extends BaseExceptionInterface
    with LocalizationOperationMixin {
  OneException(String path, String code, [StackTrace? stackTrace])
      : super(
            LocalizationOperationMixin.getMessage('$path.$code') ??
                'unknown-error',
            code: code,
            stackTrace: stackTrace);

  @override
  String toString() => '$runtimeType: $code - $message';
}
