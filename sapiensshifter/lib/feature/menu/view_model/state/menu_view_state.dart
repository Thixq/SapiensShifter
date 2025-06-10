// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

final class MenuViewState {
  MenuViewState({
    required this.isLoading,
    required this.isLoadingCategories,
    required this.table,
    required this.categories,
    required this.productList,
  });
  factory MenuViewState.initial({required TableModel table}) {
    return MenuViewState(
      isLoadingCategories: false,
      isLoading: false,
      productList: [],
      categories: [],
      table: table,
    );
  }

  final List<ProductModel> productList;
  final List<CategoriesModel> categories;
  final TableModel table;
  final bool isLoading;
  final bool isLoadingCategories;

  MenuViewState copyWith({
    List<ProductModel>? productList,
    List<CategoriesModel>? categories,
    TableModel? table,
    bool? isLoading,
    bool? isLoadingCategories,
  }) {
    return MenuViewState(
      productList: productList ?? this.productList,
      categories: categories ?? this.categories,
      table: table ?? this.table,
      isLoading: isLoading ?? this.isLoading,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
    );
  }
}
