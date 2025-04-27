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
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
          weekEnd: $checkedConvert(
              'weekEnd',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
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
      'weekStart':
          const TimestampNullableConverter().toJson(instance.weekStart),
      'weekEnd': const TimestampNullableConverter().toJson(instance.weekEnd),
      'week': instance.week?.map((e) => e.toJson()).toList(),
    };
