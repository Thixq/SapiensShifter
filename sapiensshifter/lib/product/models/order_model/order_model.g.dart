// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'OrderModel',
      json,
      ($checkedConvert) {
        final val = OrderModel(
          id: $checkedConvert('id', (v) => v as String?),
          orderName: $checkedConvert('orderName', (v) => v as String?),
          imagePath: $checkedConvert('imagePath', (v) => v as String?),
          price: $checkedConvert('price', (v) => (v as num?)?.toDouble()),
          deliveryStatus: $checkedConvert('deliveryStatus',
              (v) => $enumDecodeNullable(_$DeliveryStatusEnumMap, v)),
          extras: $checkedConvert('extras',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          status: $checkedConvert('status', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderName': instance.orderName,
      'imagePath': instance.imagePath,
      'price': instance.price,
      'status': instance.status,
      'deliveryStatus': _$DeliveryStatusEnumMap[instance.deliveryStatus],
      'extras': instance.extras,
    };

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.HERE_IN: 'here_in',
  DeliveryStatus.TAKE_AWAY: 'take_away',
};
