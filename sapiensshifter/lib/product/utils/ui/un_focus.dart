import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class KeyboardDismissOnTap extends StatelessWidget {
  const KeyboardDismissOnTap({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      behavior: HitTestBehavior.translucent,
      onTap: () => context.general.unfocus(),
      child: child,
    );
  }
}
