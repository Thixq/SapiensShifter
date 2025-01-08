import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
final class ProductModel {
  ProductModel({
    this.id,
    this.productName,
    this.description,
    this.imagePath,
    this.price,
    this.category,
    this.extrasList,
  });

  final String? id;
  final String? productName;
  final String? description;
  final String? imagePath;
  final double? price;
  final String? category;
  // TODO(kaan): Extra modelini ekle.
  final List<String>? extrasList;

  @override
  String toString() {
    return 'ProductModel(id: $id, productName: $productName, description: $description, imagePath: $imagePath, price: $price, category: $category, extrasList: $extrasList)';
  }

  ProductModel copyWith({
    String? id,
    String? productName,
    String? description,
    String? imagePath,
    double? price,
    String? category,
    List<String>? extrasList,
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
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }
}
