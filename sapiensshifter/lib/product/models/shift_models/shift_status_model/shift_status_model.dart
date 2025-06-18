import 'package:core/core.dart';
import 'package:flutter/material.dart' show Color, IconData, Icons;
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/core/constant/color_constant.dart';

import 'package:sapiensshifter/product/utils/enums/shift_status_enum.dart';

part 'func/private_func.dart';

part 'shift_status_model.g.dart';

@JsonSerializable(checked: true)
final class ShiftStatusModel extends IBaseModel<ShiftStatusModel>
    with ShiftStatusMixin {
  ShiftStatusModel({
    super.id,
    this.range,
    this.status,
  }) {
    _statusFill = statusFill(shiftStatus: status);
    statusColor = _statusFill.statusColor;
    statusIcon = _statusFill.statusIcon;
  }

  factory ShiftStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftStatusModelFromJson(json);
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  late final _statusData _statusFill;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  late final Color? statusColor;
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  late final IconData? statusIcon;
  final String? range;
  final ShiftStatusEnum? status;

  @override
  ShiftStatusModel fromJson(Map<String, dynamic> json) =>
      _$ShiftStatusModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShiftStatusModelToJson(this);
}
