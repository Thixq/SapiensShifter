import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'shift_week_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class ShiftWeek extends IBaseModel<ShiftWeek> with EquatableMixin {
  const ShiftWeek({
    super.id,
    this.weekStart,
    this.weekEnd,
    this.week,
  });

  factory ShiftWeek.fromJson(Map<String, dynamic> json) =>
      _$ShiftWeekFromJson(json);

  @TimestampNullableConverter()
  final DateTime? weekStart;
  @TimestampNullableConverter()
  final DateTime? weekEnd;

  final List<ShiftDay>? week;

  @override
  List<Object?> get props => [id, weekStart, weekEnd];

  @override
  ShiftWeek fromJson(Map<String, dynamic> json) => _$ShiftWeekFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftWeekToJson(this);
}
