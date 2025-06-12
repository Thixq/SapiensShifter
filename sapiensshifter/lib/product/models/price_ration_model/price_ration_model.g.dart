// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_ration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRationModel _$PriceRationModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PriceRationModel',
      json,
      ($checkedConvert) {
        final val = PriceRationModel(
          name: $checkedConvert('name', (v) => v as String?),
          value: $checkedConvert('value', (v) => (v as num?)?.toDouble()),
          priceOperation: $checkedConvert('priceOperation',
              (v) => $enumDecodeNullable(_$PriceOperationsEnumMap, v)),
          id: $checkedConvert('id', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PriceRationModelToJson(PriceRationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'priceOperation': _$PriceOperationsEnumMap[instance.priceOperation],
    };

const _$PriceOperationsEnumMap = {
  PriceOperations.PLUS: 'plus',
  PriceOperations.PERCENTAGE: 'percentage',
};
