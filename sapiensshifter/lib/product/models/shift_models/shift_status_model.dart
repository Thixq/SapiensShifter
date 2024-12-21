import 'package:flutter/material.dart' show Color, IconData;

class ShiftStatus {
  ShiftStatus({
    this.statusColor,
    this.statusIcon,
    this.statusTime,
  });

  final Color? statusColor;
  final IconData? statusIcon;
  final String? statusTime;
}
