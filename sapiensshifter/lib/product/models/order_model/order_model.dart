// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

part 'order_model.g.dart';

@JsonSerializable(checked: true)
final class OrderModel extends IBaseModel<OrderModel> with EquatableMixin {
  const OrderModel({
    super.id,
    this.orderName,
    this.imagePath,
    this.price,
    this.deliveryStatus,
    this.extras,
    this.status = true,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  final String? orderName;
  final String? imagePath;
  final double? price;
  final bool status;
  final DeliveryStatus? deliveryStatus;
  final List<String>? extras;

  @override
  List<Object?> get props => [orderName, imagePath, price, deliveryStatus];

  @override
  OrderModel fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    String? id,
    String? orderName,
    String? imagePath,
    double? price,
    bool? status,
    DeliveryStatus? deliveryStatus,
    List<String>? extras,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderName: orderName ?? this.orderName,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      status: status ?? this.status,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      extras: extras ?? this.extras,
    );
  }
}
