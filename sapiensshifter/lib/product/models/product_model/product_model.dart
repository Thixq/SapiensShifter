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
    this.category,
    this.productOptions,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  final String? productName;
  final String? description;
  final String? imagePath;
  final double? price;
  final String? category;
  final List<String>? productOptions;

  ProductModel copyWith({
    String? id,
    String? productName,
    String? description,
    String? imagePath,
    double? price,
    String? category,
    List<String>? productOptions,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      category: category ?? this.category,
      productOptions: productOptions ?? this.productOptions,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, productName, price, category];

  @override
  ProductModel fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
