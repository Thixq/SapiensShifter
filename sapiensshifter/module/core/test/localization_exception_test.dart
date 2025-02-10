import 'package:core/core.dart';
import 'package:core/src/interfaces/localization_interface/localization_interface.dart';
import 'package:core/src/interfaces/localization_interface/localization_mixin.dart';
import 'package:test/test.dart';

void main() {
  setUp(
    () {},
  );

  test(
    'localization exception test',
    () {
      try {
        throw OneException('errors.invalid_email');
      } catch (e, stack) {
        print(stack);
      }
    },
  );
}

class EasyLocalizationProvider implements LocalizationProvider {
  @override
  String getMessage(String key) {
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
  OneException(String code, [StackTrace? stackTrace])
      : super(
            code,
            LocalizationOperationMixin.getErrorMessage(code) ?? 'unknow-error',
            stackTrace ?? StackTrace.current);

  @override
  String toString() => '$runtimeType: $code - $message';
}
