import 'package:sapiensshifter/core/logging/custom_logger.dart';

abstract class IErrorHandler {
  void showError(Object error);
  void handleError(Object error, CustomLogger logger, StackTrace stackTrace);
}
