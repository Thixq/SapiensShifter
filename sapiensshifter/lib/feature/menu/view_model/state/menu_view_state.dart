// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

class MenuViewState {
  MenuViewState({
    required this.isLoading,
    required this.table,
    required this.categories,
    required this.productList,
  });

  final List<ProductModel> productList;
  final Map<String, String> categories;
  final TableModel table;
  final bool isLoading;

  MenuViewState copyWith({
    List<ProductModel>? productList,
    Map<String, String>? categories,
    TableModel? table,
    bool? isLoading,
  }) {
    return MenuViewState(
      productList: productList ?? this.productList,
      categories: categories ?? this.categories,
      table: table ?? this.table,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
