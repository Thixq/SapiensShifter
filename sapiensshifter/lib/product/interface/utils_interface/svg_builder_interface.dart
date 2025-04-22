import 'package:flutter/material.dart';

abstract class ISvgBuilder extends StatelessWidget {
  const ISvgBuilder({
    required this.builderSize,
    super.key,
    this.svgPath,
    this.errorSvgPath,
  });

  final String? svgPath;
  final String? errorSvgPath;
  final Size builderSize;
}
