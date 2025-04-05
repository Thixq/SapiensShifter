// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';

final class MenuViewState {
  MenuViewState({
    required this.table,
    required this.categories,
    required this.productList,
  });

  final List<ProductModel> productList;
  final Map<String, String> categories;
  final TableModel table;

  MenuViewState copyWith({
    List<ProductModel>? productList,
    Map<String, String>? categories,
    TableModel? table,
  }) {
    return MenuViewState(
      productList: productList ?? this.productList,
      categories: categories ?? this.categories,
      table: table ?? this.table,
    );
  }
}
