// error_util.dart
import 'package:sapiensshifter/core/exception/interface/error_handler_interface.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

typedef ErrorMapper = Object Function(Object error, [StackTrace? stackTrace]);

class ErrorUtil {
  static final _logger = CustomLogger('Global Error Logger');

  static Future<T> runWithErrorHandlingAsync<T>({
    required Future<T> Function() action,
    required Future<T> Function() fallbackValue,
    IErrorHandler? errorHandler,
    CustomLogger? customLogger,
    ErrorMapper? errorMapper,
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
      return fallbackValue();
    }
  }

  static Future<T> runAndRethrowAsync<T>({
    required Future<T> Function() action,
    CustomLogger? customLogger,
    ErrorMapper? errorMapper,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      final mappedError = errorMapper?.call(error, stackTrace) ?? error;
      (customLogger ?? _logger).error(
        'Error re-thrown by ErrorUtil',
        error: mappedError,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  static T runWithErrorHandling<T>({
    required T Function() action,
    required T Function() fallbackValue,
    IErrorHandler? errorHandler,
    CustomLogger? customLogger,
    ErrorMapper? errorMapper,
  }) {
    try {
      return action();
    } catch (error, stackTrace) {
      final mappedError = errorMapper?.call(error, stackTrace) ?? error;

      errorHandler?.handleError(
        mappedError,
        customLogger ?? _logger,
        stackTrace,
      );

      return fallbackValue();
    }
  }
}
