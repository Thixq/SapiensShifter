import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';

class NetworkDisableExcepiton extends IBaseException {
  NetworkDisableExcepiton(
    String code, {
    Map<String, String>? optionArgs,
    StackTrace? stackTrace,
  }) : super(
          _getMessage(code, optionArgs),
          code: code,
          stackTrace: stackTrace ?? StackTrace.current,
        );

  static const String _exceptionBasePath =
      'all_exception.network_error_exception';

  static String _getMessage(String code, Map<String, String>? optionArgs) {
    return (_exceptionBasePath + code).tr(namedArgs: optionArgs);
  }
}
