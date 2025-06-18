// ignore_for_file: constant_identifier_names, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

enum ShiftStatusEnum {
  @JsonValue('opening')
  OPENING(LocaleKeys.shift_status_opening),
  @JsonValue('opening_service')
  OPENING_SERVICE(LocaleKeys.shift_status_opening_service),
  @JsonValue('closing')
  CLOSING(LocaleKeys.shift_status_closing),
  @JsonValue('closing_service')
  CLOSING_SERVICE(LocaleKeys.shift_status_closing_service),
  @JsonValue('off_day')
  OFF_DAY(LocaleKeys.shift_status_off_day),
  @JsonValue('full_day')
  FULL_DAY(LocaleKeys.shift_status_full_day),
  @JsonValue('intermediary')
  INTERMEDIARY(LocaleKeys.shift_status_intermediary);

  final String localization;
  const ShiftStatusEnum(this.localization);
}
