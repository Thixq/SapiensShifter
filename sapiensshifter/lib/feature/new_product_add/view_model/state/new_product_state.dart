// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/product_model/product_model.dart';

class NewProductState {
  NewProductState({
    required this.category,
    required this.extras,
    required this.product,
  });

  factory NewProductState.initial({required String id}) {
    return NewProductState(
      category: {},
      extras: {},
      product: ProductModel(id: id),
    );
  }

  final Map<String, String> category;
  final Map<String, String> extras;
  final ProductModel product;

  NewProductState copyWith({
    Map<String, String>? category,
    Map<String, String>? extras,
    ProductModel? product,
  }) {
    return NewProductState(
      category: category ?? this.category,
      extras: extras ?? this.extras,
      product: product ?? this.product,
    );
  }
}
