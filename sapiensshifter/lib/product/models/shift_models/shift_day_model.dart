import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/interface/interface_model/i_base_model.dart';
import 'package:sapiensshifter/product/utils/enums/shift_status_enum.dart';

part 'shift_day_model.g.dart';

@JsonSerializable(checked: true)
final class ShiftDay extends Equatable implements IBaseModel {
  const ShiftDay({
    this.branch,
    this.shiftStatus,
    this.time,
  });

  @override
  factory ShiftDay.fromJson(Map<String, dynamic> json) =>
      _$ShiftDayFromJson(json);

  final String? branch;
  final ShiftStatusEnum? shiftStatus;
  final DateTime? time;

  @override
  List<Object?> get props => [branch, time, shiftStatus];

  @override
  Map<String, dynamic> toJson() => _$ShiftDayToJson(this);

  @override
  ShiftDay fromJson(Map<String, dynamic> json) => ShiftDay.fromJson(json);
}
