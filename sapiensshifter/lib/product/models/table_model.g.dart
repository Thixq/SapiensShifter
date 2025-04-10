// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TableModel',
      json,
      ($checkedConvert) {
        final val = TableModel(
          id: $checkedConvert('id', (v) => v as String?),
          tableName: $checkedConvert('tableName', (v) => v as String?),
          timeStamp: $checkedConvert(
              'timeStamp',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
          creatorId: $checkedConvert('creatorId', (v) => v as String?),
          branchName: $checkedConvert('branchName', (v) => v as String?),
          peopleCount:
              $checkedConvert('peopleCount', (v) => (v as num?)?.toInt()),
          status: $checkedConvert('status', (v) => v as bool?),
          closingTime: $checkedConvert(
              'closingTime',
              (v) =>
                  const TimestampNullableConverter().fromJson(v as Timestamp?)),
          orderList: $checkedConvert(
              'orderList',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => OrderModel.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableName': instance.tableName,
      'timeStamp':
          const TimestampNullableConverter().toJson(instance.timeStamp),
      'creatorId': instance.creatorId,
      'branchName': instance.branchName,
      'peopleCount': instance.peopleCount,
      'status': instance.status,
      'closingTime':
          const TimestampNullableConverter().toJson(instance.closingTime),
      'orderList': instance.orderList.map((e) => e.toJson()).toList(),
    };
