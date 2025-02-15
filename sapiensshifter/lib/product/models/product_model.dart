import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/models/extras_model.dart';

part 'product_model.g.dart';

@JsonSerializable(checked: true)
final class ProductModel extends BaseModelInterface<ProductModel>
    with EquatableMixin {
  const ProductModel({
    this.id,
    this.productName,
    this.description,
    this.imagePath,
    this.price,
    this.category,
    this.extrasList,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  final String? id;
  final String? productName;
  final String? description;
  final String? imagePath;
  final double? price;
  final String? category;
  final List<ExtrasModel>? extrasList;

  ProductModel copyWith({
    String? id,
    String? productName,
    String? description,
    String? imagePath,
    double? price,
    String? category,
    List<ExtrasModel>? extrasList,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      category: category ?? this.category,
      extrasList: extrasList ?? this.extrasList,
    );
  }

  @override
  List<Object?> get props =>
      [id, productName, description, imagePath, price, category];

  @override
  ProductModel fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
