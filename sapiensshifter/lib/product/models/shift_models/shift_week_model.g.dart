// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_week_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftWeek _$ShiftWeekFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ShiftWeek',
      json,
      ($checkedConvert) {
        final val = ShiftWeek(
          id: $checkedConvert('id', (v) => v as String?),
          weekStart: $checkedConvert(
              'weekStart',
              (v) => _$JsonConverterFromJson<Timestamp, DateTime>(
                  v, const TimestampConverter().fromJson)),
          weekEnd: $checkedConvert(
              'weekEnd',
              (v) => _$JsonConverterFromJson<Timestamp, DateTime>(
                  v, const TimestampConverter().fromJson)),
          week: $checkedConvert(
              'week',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ShiftDay.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShiftWeekToJson(ShiftWeek instance) => <String, dynamic>{
      'id': instance.id,
      'weekStart': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.weekStart, const TimestampConverter().toJson),
      'weekEnd': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.weekEnd, const TimestampConverter().toJson),
      'week': instance.week?.map((e) => e.toJson()).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
