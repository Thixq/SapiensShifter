import 'package:sapiensshifter/core/exception/interface/error_handler_interface.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

/// [AppErrorHandler] is a concrete implementation of [IErrorHandler].
/// This class handles application errors by logging them and displaying error information.
///
/// Responsibilities:
/// - Log errors using the provided [CustomLogger].
/// - Display errors to the user (implementation pending in [showError]).
class AppErrorHandler implements IErrorHandler {
  @override
  void handleError(Object error, CustomLogger logger, StackTrace stackTrace) {
    logger.error('$error', stackTrace: stackTrace);
    showError(error);
  }

  @override
  void showError(Object error) {}
}
