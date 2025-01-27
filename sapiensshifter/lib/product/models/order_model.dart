import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/interface/interface_model/product_base_model_interface.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

part 'order_model.g.dart';

@JsonSerializable(checked: true)
final class OrderModel extends Equatable
    implements ProductBaseModelInterface<OrderModel> {
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
}
