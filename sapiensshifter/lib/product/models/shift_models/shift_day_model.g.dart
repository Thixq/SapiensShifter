// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftDay _$ShiftDayFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ShiftDay',
      json,
      ($checkedConvert) {
        final val = ShiftDay(
          branchId: $checkedConvert('branchId', (v) => v as String?),
          shiftStatusId: $checkedConvert('shiftStatusId', (v) => v as String?),
          shiftStatus: $checkedConvert(
              'shiftStatus',
              (v) => v == null
                  ? null
                  : ShiftStatusModel.fromJson(v as Map<String, dynamic>)),
          branchName: $checkedConvert('branchName', (v) => v as String?),
          time: $checkedConvert(
              'time',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShiftDayToJson(ShiftDay instance) => <String, dynamic>{
      'branchId': instance.branchId,
      'branchName': instance.branchName,
      'shiftStatusId': instance.shiftStatusId,
      'shiftStatus': instance.shiftStatus?.toJson(),
      'time': const TimestampNullableConverter().toJson(instance.time),
    };
