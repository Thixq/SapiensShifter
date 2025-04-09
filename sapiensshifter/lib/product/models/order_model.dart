// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

part 'order_model.g.dart';

@JsonSerializable(checked: true)
final class OrderModel extends IBaseModel<OrderModel> with EquatableMixin {
  const OrderModel({
    this.orderName,
    this.imagePath,
    this.price,
    this.deliveryStatus,
    this.extras,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  final String? orderName;
  final String? imagePath;
  final double? price;
  final DeliveryStatus? deliveryStatus;
  final List<String>? extras;

  @override
  List<Object?> get props => [orderName, imagePath, price, deliveryStatus];

  @override
  OrderModel fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    String? orderName,
    String? imagePath,
    double? price,
    DeliveryStatus? deliveryStatus,
    List<String>? extras,
  }) {
    return OrderModel(
      orderName: orderName ?? this.orderName,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      extras: extras ?? this.extras,
    );
  }
}
