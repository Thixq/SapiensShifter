// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum DeliveryStatus {
  @JsonValue('here_in')
  HERE_IN,
  @JsonValue('take_away')
  TAKE_AWAY,
}
