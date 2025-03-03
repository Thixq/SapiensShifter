// ignore_for_file: inference_failure_on_function_invocation
import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Hata dialogunu göstermek için ortak metodumuz.
Future<void> _showErrorDialog(
  BuildContext context,
  IBaseException error,
) async {
  await showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text('${error.code}'),
      content: Text(error.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}

Future<T>? asyncHandler<T, E extends IBaseException>(
  Future<T> Function() operation, {
  required BuildContext context,
  void Function(Object error, [StackTrace? stackTrace])? onError,
}) async {
  try {
    return await operation();
  } catch (error, stack) {
    if (onError != null) {
      onError(error, stack);
      return Future.value();
    }
    if (error is IBaseException) await _showErrorDialog(context, error);
    rethrow;
  }
}
