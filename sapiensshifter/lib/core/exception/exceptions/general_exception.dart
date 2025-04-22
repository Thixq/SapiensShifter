import 'package:core/core.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class GeneralException extends IBaseException {
  GeneralException(
    String code, {
    Map<String, String>? optionArgs,
    StackTrace? stackTrace,
  }) : super(
          _getMessage(code, optionArgs),
          code: code,
          stackTrace: stackTrace ?? StackTrace.current,
        );
  static const String _exceptionBasePath = 'all_exception.general_exception.';
  static String _getMessage(String code, Map<String, String>? optionArgs) {
    return (_exceptionBasePath + code).tr(namedArgs: optionArgs);
  }

  @override
  String toString() {
    return 'GenericException: $message';
  }
}
