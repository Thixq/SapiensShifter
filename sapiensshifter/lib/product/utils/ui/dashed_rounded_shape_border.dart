import 'package:flutter/material.dart';

final class DashedRoundedShapeBorder extends ShapeBorder {
  const DashedRoundedShapeBorder({
    this.dashWidth = 5.0,
    double? dashSpace,
    this.cornerRadius = 0,
    this.borderSide = BorderSide.none,
  }) : dashSpace = dashSpace ?? (dashWidth / 2);

  final double dashWidth;
  final double dashSpace;
  final double cornerRadius;
  final BorderSide borderSide;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = borderSide.toPaint();

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final start = distance;
        final end = (distance + dashWidth).clamp(0, metric.length).toDouble();
        canvas.drawPath(metric.extractPath(start, end), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  ShapeBorder scale(double t) {
    return DashedRoundedShapeBorder(
      dashWidth: dashWidth * t,
      dashSpace: dashSpace * t,
      cornerRadius: cornerRadius * t,
      borderSide: borderSide.scale(t),
    );
  }
}
