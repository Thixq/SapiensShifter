// error_util.dart
import 'package:sapiensshifter/core/exception/interface/error_handler_interface.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

typedef ErrorMapper = Object Function(Object error, [StackTrace? stackTrace]);

/// Provides utility methods for executing functions with robust error handling.
///
/// This class offers static methods to wrap function execution (both synchronous
/// and asynchronous) in a try-catch block. It allows for custom error mapping,
/// centralized error handling via an [IErrorHandler], logging via [CustomLogger],
/// and returns a fallback value upon encountering an error.
class ErrorUtil {
  /// Internal default logger used when no specific logger is provided to the methods.
  static final _logger = CustomLogger('Global Error Logger');

  /// Executes an asynchronous [action] with robust error handling, returning a [fallbackValue] on failure.
  ///
  /// Wraps the execution of the provided asynchronous `action` function in a try-catch block.
  /// If the [action] completes successfully, its result of type [T] is returned.
  ///
  /// If any exception is caught during the execution of [action]:
  /// 1. The `error` is optionally transformed by the `errorMapper` function, if provided.
  /// 2. The (potentially mapped) error is passed to the `errorHandler`'s `handleError` method,
  ///    if an `errorHandler` instance is provided. Logging is done using the `customLogger`
  ///    (if provided) or the default internal [_logger].
  /// 3. The specified `fallbackValue` of type [T] is returned.
  ///
  /// This method simplifies safely executing asynchronous operations, ensuring that
  /// errors are caught, logged (if configured), and a predictable value is returned,
  /// preventing uncaught exceptions.
  ///
  /// Example:
  /// ```dart
  /// var result = await ErrorUtil.runWithErrorHandlingAsync<String>(
  ///   action: () async => await fetchUserData(), // An async function that might throw
  ///   fallbackValue: "Default User",
  ///   errorHandler: myErrorHandler, // Optional: your IErrorHandler implementation
  ///   customLogger: mySpecificLogger, // Optional: your CustomLogger instance
  /// );
  /// result will be the user data string or "Default User" if fetchUserData failed.
  /// ```
  ///
  /// Parameters:
  ///   - `action`: The asynchronous `Future<T> Function()` to execute.
  ///   - `fallbackValue`: The value of type [T] to return if an error occurs.
  ///   - `errorHandler`: An optional [IErrorHandler] implementation to process caught errors.
  ///   - `customLogger`: An optional [CustomLogger] for logging. Defaults to the internal [_logger] if null.
  ///   - `errorMapper`: An optional function `Object Function(Object error, [StackTrace? stackTrace])?`
  ///     to transform the caught error object before handling and logging.
  ///
  /// Returns: A `Future<T>` that completes with the result of `action` or the `fallbackValue`.
  static Future<T> runWithErrorHandlingAsync<T>({
    required Future<T> Function() action,
    required T Function() fallbackValue,
    IErrorHandler? errorHandler,
    CustomLogger? customLogger,
    ErrorMapper? errorMapper,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      final mappedError = errorMapper?.call(error, stackTrace) ?? error;
      // Use the provided error handler if available
      errorHandler?.handleError(
        mappedError,
        customLogger ?? _logger, // Use custom logger or default
        stackTrace,
      );
      // Log directly if no error handler is provided but a custom logger is?
      // Or should logging only happen *within* the handler?
      // Current implementation: Handler is responsible for logging.
      // If no handler, the error is caught but not logged (unless mapper throws).
      return fallbackValue();
    }
  }

  /// Executes a synchronous [action] with robust error handling, returning a [fallbackValue] on failure.
  ///
  /// Wraps the execution of the provided synchronous `action` function in a try-catch block.
  /// If the [action] completes successfully, its result of type [T] is returned.
  ///
  /// If any exception is caught during the execution of [action]:
  /// 1. The `error` is optionally transformed by the `errorMapper` function, if provided.
  /// 2. The (potentially mapped) error is passed to the `errorHandler`'s `handleError` method,
  ///    if an `errorHandler` instance is provided. Logging is done using the `customLogger`
  ///    (if provided) or the default internal [_logger].
  /// 3. The specified `fallbackValue` of type [T] is returned.
  ///
  /// This method simplifies safely executing synchronous operations, ensuring that
  /// errors are caught, logged (if configured), and a predictable value is returned.
  ///
  /// Example:
  /// ```dart
  /// var result = ErrorUtil.runWithErrorHandling<int>(
  ///   action: () => performCalculation(), // A sync function that might throw
  ///   fallbackValue: -1,
  ///   errorHandler: myErrorHandler, // Optional: your IErrorHandler implementation
  /// );
  ///  result will be the calculation result or -1 if performCalculation failed.
  /// ```
  ///
  /// Parameters:
  ///   - `action`: The synchronous `T Function()` to execute.
  ///   - `fallbackValue`: The value of type [T] to return if an error occurs.
  ///   - `errorHandler`: An optional [IErrorHandler] implementation to process caught errors.
  ///   - `customLogger`: An optional [CustomLogger] for logging. Defaults to the internal [_logger] if null.
  ///   - `errorMapper`: An optional function `Object Function(Object error, [StackTrace? stackTrace])?`
  ///     to transform the caught error object before handling and logging.
  ///
  /// Returns: The result of `action` or the `fallbackValue` if an error occurred.
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
      // Use the provided error handler if available
      errorHandler?.handleError(
        mappedError,
        customLogger ?? _logger, // Use custom logger or default
        stackTrace,
      );
      // Similar consideration as the async version regarding logging responsibility.
      return fallbackValue();
    }
  }
}
