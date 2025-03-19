// error_util.dart
import 'package:sapiensshifter/core/exception/interface/error_handler_interface.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

class ErrorUtil {
  static final _logger = CustomLogger('Global Error Logger');
  static Future<T> runWithErrorHandling<T>({
    required Future<T> Function() action,
    required T fallbackValue,
    IErrorHandler? errorHandler,
    CustomLogger? customLogger,
    Object Function(Object error, [StackTrace? stackTrace])? errorMapper,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      final mappedError = errorMapper?.call(error, stackTrace) ?? error;
      errorHandler?.handleError(
        mappedError,
        customLogger ?? _logger,
        stackTrace,
      );
      return fallbackValue;
    }
  }
}
