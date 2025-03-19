import 'package:sapiensshifter/core/exception/interface/error_handler_interface.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

class AppErrorHandler implements IErrorHandler {
  @override
  void handleError(Object error, CustomLogger logger, StackTrace stackTrace) {
    logger.info('$error');
    showError(error);
  }

  @override
  void showError(Object error) {}
}
