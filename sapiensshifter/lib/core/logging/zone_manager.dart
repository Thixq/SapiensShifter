import 'dart:async';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

/// ZoneManager is a utility class to run the application within a protected zone.
/// It catches and logs any unhandled errors globally.
class ZoneManager {
  // Creating a static instance of CustomLogger for logging messages within ZoneManager.
  static final CustomLogger _logger = CustomLogger('ZoneManager');

  /// Executes the provided [appMain] function inside a guarded zone.
  /// Any uncaught errors are intercepted and logged via the error callback.
  static void runAppInZone(Future<void> Function() appMain) {
    // runZonedGuarded runs the [appMain] function inside a new error-handling zone.
    runZonedGuarded<Future<void>>(
      appMain, // The main application function to execute.
      // Error callback that gets invoked when an uncaught error occurs in the zone.
      (error, stackTrace) {
        // Log the caught error with an appropriate message, including error details and stack trace.
        _logger.error(
          'Global error caught! \n $error',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }
}
