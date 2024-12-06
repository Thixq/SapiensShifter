import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

class SapiButton extends StatelessWidget {
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
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  ButtonStyle _sapiButtonStyle(BuildContext context) {
    return ButtonStyle(
      padding: WidgetStatePropertyAll(
        context.padding.verticalMedium,
      ),
      minimumSize: WidgetStatePropertyAll(
        Size(80.w, 0),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
