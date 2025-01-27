import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/interface/interface_model/product_base_model_interface.dart';
import 'package:sapiensshifter/product/models/order_model.dart';

part 'table_model.g.dart';

@JsonSerializable(checked: true)
final class TableModel extends Equatable
    implements ProductBaseModelInterface<TableModel> {
  const TableModel({
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

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);
  final String? id;
  final String? tableName;
  final DateTime? timeStamp;
  final String? creatorId;
  final String? branchName;
  final int? peopleCount;
  final bool? status;
  final DateTime? closingTime;
  final List<OrderModel>? orderList;

  @override
  List<Object?> get props => [id, tableName, timeStamp, creatorId, branchName];

  @override
  TableModel fromJson(Map<String, dynamic> json) => _$TableModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TableModelToJson(this);

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
