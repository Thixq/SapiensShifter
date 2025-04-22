// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProductModel',
      json,
      ($checkedConvert) {
        final val = ProductModel(
          id: $checkedConvert('id', (v) => v as String?),
          productName: $checkedConvert('productName', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          imagePath: $checkedConvert('imagePath', (v) => v as String?),
          price: $checkedConvert('price', (v) => (v as num?)?.toDouble()),
          category: $checkedConvert('category', (v) => v as String?),
          productOptions: $checkedConvert('productOptions',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'price': instance.price,
      'category': instance.category,
      'productOptions': instance.productOptions,
    };
