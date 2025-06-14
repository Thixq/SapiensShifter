// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/price_ration_model/price_ration_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';

final class ProductPriceEditState {
  final List<ProductModel> originalList;
  final List<ProductModel> mainList;
  final List<ProductModel> filteredList;
  final Set<ProductModel> selectedList;
  final Set<ProductModel> selectedChangeList;
  final bool allSelected;
  final Map<String, String> categories;
  final Map<String, PriceRationModel> priceRations;
  final bool isLoading;

  const ProductPriceEditState({
    required this.originalList,
    required this.mainList,
    required this.filteredList,
    required this.selectedList,
    required this.selectedChangeList,
    required this.allSelected,
    required this.categories,
    required this.priceRations,
    required this.isLoading,
  });

  factory ProductPriceEditState.initial({
    List<ProductModel> mainList = const [],
    Map<String, PriceRationModel> priceRations = const {},
    Map<String, String> categories = const {},
  }) {
    return ProductPriceEditState(
      originalList: mainList,
      mainList: mainList,
      filteredList: mainList,
      selectedList: {},
      selectedChangeList: {},
      allSelected: false,
      categories: categories,
      priceRations: priceRations,
      isLoading: false,
    );
  }

  ProductPriceEditState copyWith({
    List<ProductModel>? originalList,
    List<ProductModel>? mainList,
    List<ProductModel>? filteredList,
    Set<ProductModel>? selectedList,
    Set<ProductModel>? selectedChangeList,
    bool? allSelected,
    Map<String, String>? categories,
    Map<String, PriceRationModel>? priceRations,
    bool? isLoading,
  }) {
    return ProductPriceEditState(
      originalList: originalList ?? this.originalList,
      mainList: mainList ?? this.mainList,
      filteredList: filteredList ?? this.filteredList,
      selectedList: selectedList ?? this.selectedList,
      selectedChangeList: selectedChangeList ?? this.selectedChangeList,
      allSelected: allSelected ?? this.allSelected,
      categories: categories ?? this.categories,
      priceRations: priceRations ?? this.priceRations,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
