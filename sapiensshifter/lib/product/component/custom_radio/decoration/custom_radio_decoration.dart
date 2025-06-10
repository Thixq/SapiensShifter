import 'package:flutter/material.dart';

class CustomRadioDecoration {
  const CustomRadioDecoration({
    this.backgroundColor = Colors.white,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
    this.selectedColor = Colors.blue,
  });

  final Color selectedColor;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
}
