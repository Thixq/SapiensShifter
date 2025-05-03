import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// LoggingManager is responsible for initializing and configuring the logging settings.
class LoggingManager {
  // Declare a variable to hold the formatted log message.
  static String? _logMessage;

  /// Initializes logging with an optional [level]. If no level is provided, it sets the log level based on the build mode.
  static void init({Level? level}) {
    // Determine the logging level:
    // - Use the provided level if available.
    // - If not provided, use Level.WARNING in release mode, otherwise Level.ALL (to log all messages in debug mode).
    final logLevel = level ?? (kReleaseMode ? Level.WARNING : Level.ALL);

    // Set the root logger's level to control which log messages are processed.
    Logger.root.level = logLevel;

    // Listen to log records from the root logger.
    Logger.root.onRecord.listen((record) {
      // Format the log message with level, time, logger name, message, and stack trace (if available).
      _logMessage =
          '${record.level.name} -- ${record.time} -- ${record.loggerName}: ${record.message} \n ${record.stackTrace ?? ''}';
      // Print the formatted log message to the console.
      debugPrint(_logMessage);
    });

    // Override Flutter's default error handling to print Flutter errors to the console.
    FlutterError.onError = (FlutterErrorDetails details) {
      debugPrint(details.exception.toString());
    };
  }
}
