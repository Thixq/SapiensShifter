import 'package:core/core.dart';
import 'package:core/src/interfaces/localization_interface/localization_interface.dart';
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
        throw OneException('errors.invalid_email');
      } catch (e) {
        print(e.toString());
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

class OneException extends BaseExceptionInterface {
  OneException(String code, [StackTrace? stackTrace])
      : super(
            code, _getMessageFromCode(code), stackTrace ?? StackTrace.current);

  static String _getMessageFromCode(String code) {
    if (code == 'oneError') {
      return 'oneError Message, oneError Message';
    } else if (code == 'twoError') {
      return 'twoError Message, twoError Message';
    }
    return 'Unknown error';
  }

  @override
  String toString() => '$runtimeType: $code - $message';
}
