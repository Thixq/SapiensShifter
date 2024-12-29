import 'package:sapiensshifter/product/models/order_model.dart';

class TableModel {
  TableModel({
    this.id,
    this.tableName,
    this.timeStamp,
    this.creatorId,
    this.branchName,
    this.peopleCount,
    this.status,
    this.closingTime,
    this.orderList,
  });
  String? id;
  String? tableName;
  DateTime? timeStamp;
  String? creatorId;
  String? branchName;
  int? peopleCount;
  bool? status;
  DateTime? closingTime;
  List<OrderModel>? orderList;

  // ignore: use_if_null_to_convert_nulls_to_bools
  double? get totalPrice => orderList?.isNotEmpty == true
      ? orderList!
          .where(
            (e) => e.price != null,
          )
          .map((e) => e.price!)
          // ignore: prefer_int_literals
          .fold(0.0, (total, price) => total! + price)
      : null;
}
