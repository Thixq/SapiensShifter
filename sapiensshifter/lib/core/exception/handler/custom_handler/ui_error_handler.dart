// ui_error_handler.dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/exception/handler/app_handler.dart';
import 'package:sapiensshifter/core/utils/mixin/exception/show_excepiton_dialog/show_exception_dialog.dart';

/// Using [UIErrorHandler] allows the received error to be displayed on the
/// screen with a popup.
final class UIErrorHandler extends AppErrorHandler
    with ShowExceptionDialogMixin {
  UIErrorHandler(this.context);
  final BuildContext context;

  @override
  void showError(Object error) {
    if (error is IBaseException) {
      showErrorDialog(context, title: error.code, desc: error.message);
    } else {
      showErrorDialog(context, desc: error.toString());
    }
  }
}
