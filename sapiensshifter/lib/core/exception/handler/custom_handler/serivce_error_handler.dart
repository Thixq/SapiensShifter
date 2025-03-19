import 'package:sapiensshifter/core/exception/handler/app_handler.dart';

///You can log the received line with [ServiceErrorHandler]. And you can do
///your own logging.
final class ServiceErrorHandler extends AppErrorHandler {
  @override
  void showError(Object error) {}
}
