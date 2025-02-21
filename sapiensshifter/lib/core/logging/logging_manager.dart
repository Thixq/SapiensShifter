import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingManager {
  static void init({Level? level}) {
    final logLevel = level ?? (kReleaseMode ? Level.WARNING : Level.ALL);
    Logger.root.level = logLevel;
    String? logMessage;

    Logger.root.onRecord.listen((record) {
      logMessage =
          '${record.level.name} -- ${record.time} -- ${record.loggerName}: ${record.message} \n ${record.stackTrace ?? 'Stack Trace is Null'}';
      debugPrint(logMessage);
    });
    FlutterError.onError = (FlutterErrorDetails details) {
      // Hataları konsola yaz
      debugPrint(logMessage);
    };
  }
}
