import 'package:flutter/material.dart';

///
mixin ShowExceptionDialogMixin {
  Future<void> showErrorDialog(
    BuildContext context, {
    required String desc,
    String? title,
  }) {
    return showAdaptiveDialog(
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
