import 'package:sapiensshifter/product/export_dependency_package/shift_export.dart';

final class ShiftWeek {
  ShiftWeek({
    this.weekStart,
    this.weekEnd,
    this.week,
  });

  final DateTime? weekStart;
  final DateTime? weekEnd;
  final List<ShiftDay>? week;
}
