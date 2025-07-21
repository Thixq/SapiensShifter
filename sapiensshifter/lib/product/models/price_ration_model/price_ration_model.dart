import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';

part 'price_ration_model.g.dart';

@JsonSerializable(checked: true)
final class PriceRationModel extends IBaseModel<PriceRationModel>
    with EquatableMixin {
  PriceRationModel({
    this.name,
    this.value,
    this.priceOperation,
    super.id,
  });

  factory PriceRationModel.fromJson(Map<String, dynamic> json) =>
      _$PriceRationModelFromJson(json);

  final String? name;
  final double? value;
  final PriceOperations? priceOperation;

  @override
  PriceRationModel fromJson(Map<String, dynamic> json) =>
      _$PriceRationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PriceRationModelToJson(this);

  @override
  List<Object?> get props => [id];
}
