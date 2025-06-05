import 'dart:ui';
import 'package:flutter/material.dart';

class DashedRoundedShapeBorder extends ShapeBorder {
  const DashedRoundedShapeBorder({
    this.borderRadius = BorderRadius.zero,
    this.side = BorderSide.none,
    this.dashLength = 5.0,
    this.gapLength = 3.0,
  });
  final BorderRadius borderRadius;
  final BorderSide side;
  final double dashLength;
  final double gapLength;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return DashedRoundedShapeBorder(
      borderRadius: borderRadius * t,
      side: side.scale(t),
      dashLength: dashLength * t,
      gapLength: gapLength * t,
    );
  }

  /// StrokeAlign için rect ayarı:
  Rect _adjustRect(Rect rect, BorderSide side) {
    return rect.deflate(side.strokeInset);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final adjustedRect = _adjustRect(rect, side);
    return Path()..addRRect(borderRadius.toRRect(adjustedRect));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final adjustedRect = _adjustRect(rect, side);
    final outer = borderRadius.toRRect(adjustedRect);
    final inner = outer.deflate(side.width);
    return Path()..addRRect(inner);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width == 0.0) return;

    final paint = Paint()
      ..color = side.color
      ..strokeWidth = side.width
      ..style = PaintingStyle.stroke;

    final adjustedRect = _adjustRect(rect, side);
    final a = adjustedRect.inflate(side.strokeAlign / 2);
    final path = Path()..addRRect(borderRadius.toRRect(a));

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      var drawDash = true;
      while (distance < metric.length) {
        final len = drawDash ? dashLength : gapLength;
        final end = (distance + len).clamp(0.0, metric.length);
        if (drawDash) {
          final segment = metric.extractPath(distance, end);
          canvas.drawPath(segment, paint);
        }
        distance += len;
        drawDash = !drawDash;
      }
    }
  }

  @override
  bool get preferPaintInterior => false;

  @override
  ShapeBorder lerpFrom(ShapeBorder? a, double t) {
    if (a is DashedRoundedShapeBorder) {
      return DashedRoundedShapeBorder(
        borderRadius:
            BorderRadius.lerp(a.borderRadius, borderRadius, t) ?? borderRadius,
        side: BorderSide.lerp(a.side, side, t),
        dashLength: lerpDouble(a.dashLength, dashLength, t)!,
        gapLength: lerpDouble(a.gapLength, gapLength, t)!,
      );
    }
    return super.lerpFrom(a, t) ?? this;
  }

  @override
  ShapeBorder lerpTo(ShapeBorder? b, double t) {
    if (b is DashedRoundedShapeBorder) {
      return DashedRoundedShapeBorder(
        borderRadius:
            BorderRadius.lerp(borderRadius, b.borderRadius, t) ?? borderRadius,
        side: BorderSide.lerp(side, b.side, t),
        dashLength: lerpDouble(dashLength, b.dashLength, t)!,
        gapLength: lerpDouble(gapLength, b.gapLength, t)!,
      );
    }
    return super.lerpTo(b, t) ?? this;
  }

  @override
  int get hashCode => Object.hash(borderRadius, side, dashLength, gapLength);

  @override
  bool operator ==(Object other) {
    return other is DashedRoundedShapeBorder &&
        other.borderRadius == borderRadius &&
        other.side == side &&
        other.dashLength == dashLength &&
        other.gapLength == gapLength;
  }
}
