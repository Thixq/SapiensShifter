import 'package:core/core.dart';

/// OneException: Sadece hata koduna göre mesaj belirleniyor.
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

  @override
  String getMessage(String key) {
    // TODO: implement getMessage
    throw UnimplementedError();
  }
}

/// TwoException: Hata mesajı ve hatanın oluştuğu tarih bilgisine sahip.
class TwoException extends BaseExceptionInterface {
  final DateTime errorDate;

  TwoException(String code, this.errorDate, [StackTrace? stackTrace])
      : super(code, _getMessageFromCode(code), stackTrace);

  static String _getMessageFromCode(String code) {
    if (code == 'oneError') {
      return 'TwoException oneError, TwoException oneError';
    } else if (code == 'twoError') {
      return 'TwoException twoError, TwoException twoError';
    }
    return 'Unknown error';
  }

  @override
  String toString() => '$runtimeType: $message (Occurred at: $errorDate)';

  @override
  String getMessage(String key) {
    // TODO: implement getMessage
    throw UnimplementedError();
  }
}

/// Örnek hata fırlatabilecek sınıf
class oneClass {
  const oneClass(this.a);
  final int a;

  void someFunc() {
    if (a < 100) {
      print('Success');
    } else {
      // a değeri 100 veya daha büyükse OneException fırlatılıyor.
      throw OneException('twoError');
    }
  }
}

/// processOneClass fonksiyonu, oneClass.someFunc() çağrılırken oluşan OneException'ı yakalıyor.
/// Yakalandıktan sonra, OneException'ın hata mesajını logluyor,
/// daha sonra bu mesajı ve hata oluşma tarihini kullanarak yeni bir TwoException oluşturup fırlatıyor.
Future<bool> processOneClass(int value) async {
  return await handleAsyncOperation<bool, OneException>(
    () async {
      oneClass(value).someFunc();
      return true;
    },
    errorTransformer: (error, [stackTrace]) {
      print("Logged OneException: ${error.message}");
      // Gelen OneException'ı TwoException'a dönüştürüyoruz.
      return TwoException(error.code, DateTime.now(), stackTrace);
    },
  );
}

/// Main fonksiyonunda processOneClass çağrılıyor ve TwoException yakalanıyor.
void main() async {
  try {
    print(await processOneClass(
        150)); // 150 değeri verildiği için OneException fırlatılacak.
  } on TwoException catch (e) {
    // print("Caught TwoException: ${e.toString()}");
    print(e);
  } catch (e) {
    print(e);
  }
}
