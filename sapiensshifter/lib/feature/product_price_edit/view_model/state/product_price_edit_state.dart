// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/product_model/product_model.dart';

final class ProductPriceEditState {
  final List<ProductModel> mainList;
  final List<ProductModel> originalList;
  final Set<ProductModel> selectedList;
  final Set<ProductModel> selectedChangeList;
  final bool allSelected;
  final Map<String, String> categories;
  final Map<String, double> priceRations;

  const ProductPriceEditState({
    required this.mainList,
    required this.originalList,
    required this.selectedList,
    required this.selectedChangeList,
    required this.allSelected,
    required this.categories,
    required this.priceRations,
  });

  factory ProductPriceEditState.initial({
    List<ProductModel> mainList = const [],
    Map<String, double> priceRations = const {},
  }) {
    return ProductPriceEditState(
      mainList: mainList,
      originalList: mainList,
      selectedList: {},
      selectedChangeList: {},
      allSelected: false,
      categories: {},
      priceRations: priceRations,
    );
  }

  ProductPriceEditState copyWith({
    List<ProductModel>? mainList,
    List<ProductModel>? originalList,
    Set<ProductModel>? selectedList,
    Set<ProductModel>? selectedChangeList,
    bool? allSelected,
    Map<String, String>? categories,
    Map<String, double>? priceRations,
  }) {
    return ProductPriceEditState(
      mainList: mainList ?? this.mainList,
      originalList: originalList ?? this.originalList,
      selectedList: selectedList ?? this.selectedList,
      selectedChangeList: selectedChangeList ?? this.selectedChangeList,
      allSelected: allSelected ?? this.allSelected,
      categories: categories ?? this.categories,
      priceRations: priceRations ?? this.priceRations,
    );
  }
}
