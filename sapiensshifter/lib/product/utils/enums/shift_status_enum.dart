// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum ShiftStatusEnum {
  @JsonValue('opening')
  OPENING,
  @JsonValue('opening_service')
  OPENING_SERVICE,
  @JsonValue('closing')
  CLOSING,
  @JsonValue('closing_service')
  CLOSING_SERVICE,
  @JsonValue('off_day')
  OFF_DAY,
  @JsonValue('full_day')
  FULL_DAY,
  @JsonValue('intermediary')
  INTERMEDIARY,
}
