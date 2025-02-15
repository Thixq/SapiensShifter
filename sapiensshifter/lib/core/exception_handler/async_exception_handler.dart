// ignore_for_file: inference_failure_on_function_invocation

import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Hata dialogunu göstermek için ortak metodumuz.
Future<void> _showErrorDialog(
  BuildContext context,
  BaseExceptionInterface error,
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

Future<T> asyncExceptionHandler<T, E extends BaseExceptionInterface>(
  Future<T> Function() operation, {
  required BuildContext context,
  void Function(Exception)? onError,
}) async {
  try {
    return await operation();
  } on E catch (error) {
    if (onError != null) {
      onError(error);
    }
    await _showErrorDialog(context, error);
    rethrow;
  } finally {
    // TODO: loglama yapılacak
  }
}
