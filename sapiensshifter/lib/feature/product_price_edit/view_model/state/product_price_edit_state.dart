// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/product_model/product_model.dart';

final class ProductPriceEditState {
  List<ProductModel> mainList;
  Set<ProductModel> selectedList;
  Set<ProductModel> selectedChangeList;
  bool allSelected;
  ProductPriceEditState({
    required this.mainList,
    required this.selectedList,
    required this.selectedChangeList,
    required this.allSelected,
  });

  factory ProductPriceEditState.initial({
    List<ProductModel> mainList = const [],
  }) {
    return ProductPriceEditState(
      mainList: mainList,
      selectedList: {},
      selectedChangeList: {},
      allSelected: false,
    );
  }

  ProductPriceEditState copyWith({
    List<ProductModel>? mainList,
    Set<ProductModel>? selectedList,
    Set<ProductModel>? selectedChangeList,
    bool? allSelected,
  }) {
    return ProductPriceEditState(
      mainList: mainList ?? this.mainList,
      selectedList: selectedList ?? this.selectedList,
      selectedChangeList: selectedChangeList ?? this.selectedChangeList,
      allSelected: allSelected ?? this.allSelected,
    );
  }
}
