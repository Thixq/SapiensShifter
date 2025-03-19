// ignore_for_file: unused_element, inference_failure_on_function_invocation

import 'package:flutter/material.dart';

mixin ShowExceptionDialogMixin {
  Future<void> showErrorDialog(
    BuildContext context, {
    required String desc,
    String? title,
  }) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title ?? 'Error'),
        content: Text(desc),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
