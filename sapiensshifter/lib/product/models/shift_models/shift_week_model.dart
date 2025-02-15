import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

part 'shift_week_model.g.dart';

@JsonSerializable(checked: true)
final class ShiftWeek extends BaseModelInterface<ShiftWeek>
    with EquatableMixin {
  const ShiftWeek({
    this.id,
    this.weekStart,
    this.weekEnd,
    this.week,
  });

  factory ShiftWeek.fromJson(Map<String, dynamic> json) =>
      _$ShiftWeekFromJson(json);

  final String? id;
  final DateTime? weekStart;
  final DateTime? weekEnd;
  final List<ShiftDay>? week;

  @override
  List<Object?> get props => [id, weekStart, weekEnd];

  @override
  ShiftWeek fromJson(Map<String, dynamic> json) => ShiftWeek.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftWeekToJson(this);
}
