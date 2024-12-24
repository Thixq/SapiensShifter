// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  DashedDivider({
    double? dashSpace,
    Color color = Colors.black,
    double width = 1,
    this.padding = 32,
    this.dashWidth = 5,
    super.key,
  }) : dashSpace = dashSpace ?? dashWidth / 2 {
    paintter = Paint()
      ..color = color
      ..strokeWidth = width;
  }
  final double dashWidth;
  late final double dashSpace;
  late final Paint paintter;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, padding),
      painter: DashedLinePainter(
        dashSpace: dashSpace,
        dashWidth: dashWidth,
        paintter: paintter,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    required this.paintter,
    required this.dashWidth,
    required this.dashSpace,
    super.repaint,
  });

  final Paint paintter;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: omit_local_variable_types
    double startX = 0;

    while (startX < size.width) {
      // Draw a dash
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paintter,
      );
      startX += dashWidth + dashSpace; // Move start point for next dash
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
