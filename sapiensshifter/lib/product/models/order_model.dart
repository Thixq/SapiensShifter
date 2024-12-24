import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

class OrderModel {
  OrderModel({
    this.orderName,
    this.imagePath,
    this.price,
    this.deliveryStatus,
    this.extras,
  });
  final String? orderName;
  final String? imagePath;
  final double? price;
  final DeliveryStatus? deliveryStatus;
  final List<String>? extras;
}
