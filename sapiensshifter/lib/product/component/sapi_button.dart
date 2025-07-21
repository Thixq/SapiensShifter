import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

final class SapiButton extends StatelessWidget {
  const SapiButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: _sapiButtonStyle(context),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: context.general.textTheme.titleMedium,
      ),
    );
  }
}

ButtonStyle _sapiButtonStyle(BuildContext context) {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(
      context.padding.normal,
    ),
    shape: WidgetStatePropertyAll(
      context.border.roundedRectangleAllBorderNormal,
    ),
  );
}
