// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sapiensshifter/product/models/shift_models/shift_status_model/shift_status_model.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'shift_day_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class ShiftDay extends IBaseModel<ShiftDay> with EquatableMixin {
  const ShiftDay({
    this.branchId,
    this.shiftStatusId,
    this.shiftStatus,
    this.branchName,
    this.time,
  });

  @override
  factory ShiftDay.fromJson(Map<String, dynamic> json) =>
      _$ShiftDayFromJson(json);

  final String? branchId;
  final String? branchName;
  final String? shiftStatusId;
  final ShiftStatusModel? shiftStatus;
  @TimestampNullableConverter()
  final DateTime? time;

  @override
  List<Object?> get props => [branchId, time, shiftStatusId];

  @override
  Map<String, dynamic> toJson() => _$ShiftDayToJson(this);

  @override
  ShiftDay fromJson(Map<String, dynamic> json) => _$ShiftDayFromJson(json);

  ShiftDay copyWith({
    String? branchId,
    String? shiftStatusId,
    ShiftStatusModel? shiftStatus,
    String? branchName,
    DateTime? time,
  }) {
    return ShiftDay(
      branchId: branchId ?? this.branchId,
      shiftStatusId: shiftStatusId ?? this.shiftStatusId,
      shiftStatus: shiftStatus ?? this.shiftStatus,
      branchName: branchName ?? this.branchName,
      time: time ?? this.time,
    );
  }
}
