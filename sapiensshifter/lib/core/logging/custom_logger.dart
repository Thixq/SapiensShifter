import 'package:logging/logging.dart';

class CustomLogger {
  CustomLogger(String moduleName) : _logger = Logger(moduleName);
  final Logger _logger;

  void info(String message) => _logger.info(message);
  void warning(String message) => _logger.warning(message);
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe('$message - Error: $error', error, stackTrace);
  }

  void debug(String message) => _logger.fine(message);
}
