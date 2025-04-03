// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/product_model.dart';

class MenuViewState {
  MenuViewState({
    required this.categories,
    required this.productList,
  });

  final List<ProductModel> productList;
  final Map<String, String> categories;

  MenuViewState copyWith({
    List<ProductModel>? productList,
    Map<String, String>? categories,
  }) {
    return MenuViewState(
      productList: productList ?? this.productList,
      categories: categories ?? this.categories,
    );
  }
}
