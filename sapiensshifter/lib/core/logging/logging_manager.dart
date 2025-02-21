import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingManager {
  static void init({Level? level}) {
    final logLevel = level ?? (kReleaseMode ? Level.WARNING : Level.ALL);
    Logger.root.level = logLevel;

    Logger.root.onRecord.listen((record) {
      final logMessage =
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}\n\n${record.stackTrace}';
      debugPrint(logMessage);
    });
  }
}
