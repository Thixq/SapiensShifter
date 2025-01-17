import 'package:flutter/material.dart' show Color, IconData;

final class ShiftStatus {
  const ShiftStatus({
    this.statusColor,
    this.statusIcon,
    this.statusTime,
  });

  final Color? statusColor;
  final IconData? statusIcon;
  final String? statusTime;
}
