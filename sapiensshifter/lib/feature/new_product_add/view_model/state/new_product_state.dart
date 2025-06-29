// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';

final class NewProductState {
  NewProductState({
    required this.category,
    required this.extras,
    required this.product,
  });

  factory NewProductState.initial({required String id}) {
    return NewProductState(
      category: [],
      extras: [],
      product: ProductModel(id: id),
    );
  }

  final List<CategoriesModel> category;
  final List<ExtrasModel> extras;
  final ProductModel product;

  NewProductState copyWith({
    List<CategoriesModel>? category,
    List<ExtrasModel>? extras,
    ProductModel? product,
  }) {
    return NewProductState(
      category: category ?? this.category,
      extras: extras ?? this.extras,
      product: product ?? this.product,
    );
  }
}
