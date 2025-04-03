// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sapiensshifter/product/models/order_model.dart';

part 'table_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class TableModel extends IBaseModel<TableModel> with EquatableMixin {
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

  @override
  bool get stringify => true;

  TableModel copyWith({
    String? id,
    String? tableName,
    DateTime? timeStamp,
    String? creatorId,
    String? branchName,
    int? peopleCount,
    bool? status,
    DateTime? closingTime,
    List<OrderModel>? orderList,
  }) {
    return TableModel(
      id: id ?? this.id,
      tableName: tableName ?? this.tableName,
      timeStamp: timeStamp ?? this.timeStamp,
      creatorId: creatorId ?? this.creatorId,
      branchName: branchName ?? this.branchName,
      peopleCount: peopleCount ?? this.peopleCount,
      status: status ?? this.status,
      closingTime: closingTime ?? this.closingTime,
      orderList: orderList ?? this.orderList,
    );
  }
}
