// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(checked: true)
final class ProductModel extends IBaseModel<ProductModel> with EquatableMixin {
  const ProductModel({
    super.id,
    this.productName,
    this.description,
    this.imagePath,
    this.price,
    double? orjin,
    this.category,
    this.productOptions,
  }) : originalPrice = orjin ?? price;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  final String? productName;
  final String? description;
  final String? imagePath;
  final double? price;
  final double? originalPrice;
  final String? category;
  final List<String>? productOptions;

  ProductModel copyWith({
    String? id,
    String? productName,
    String? description,
    String? imagePath,
    double? price,
    double? originalPrice,
    String? category,
    List<String>? productOptions,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      orjin: this.originalPrice,
      category: category ?? this.category,
      productOptions: productOptions ?? this.productOptions,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, productName, category];

  @override
  ProductModel fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
