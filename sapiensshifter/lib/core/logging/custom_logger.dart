import 'package:logging/logging.dart';

/// CustomLogger is a wrapper around the Logger from the logging package.
/// It provides convenient methods to log messages at various levels.
class CustomLogger {
  /// Constructs a CustomLogger with the provided [moduleName] to distinguish log sources.
  CustomLogger(String moduleName) : _logger = Logger(moduleName);
  // The underlying logger instance, identified by a module name.
  final Logger _logger;

  /// Logs an informational message.
  void info(String message) => _logger.info(message);

  /// Logs a warning message.
  void warning(String message) => _logger.warning(message);

  /// Logs an error message with optional [error] object and [stackTrace].
  /// The error is logged at the severe level.
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.severe(message, error, stackTrace);
  }

  /// Logs a debug message.
  void debug(String message) => _logger.fine(message);
}
