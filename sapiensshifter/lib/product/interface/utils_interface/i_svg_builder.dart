import 'package:flutter/material.dart';

abstract class SvgBuilder extends StatelessWidget {
  const SvgBuilder({
    required this.builderSize,
    super.key,
    this.svgPath,
    this.errorSvgPath,
  });

  final String? svgPath;
  final String? errorSvgPath;
  final Size builderSize;
}
