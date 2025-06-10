import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/state/product_price_edit_state.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';
import 'package:sapiensshifter/product/utils/static_func/price_editing.dart';

class ProductPriceEditViewModel extends BaseCubit<ProductPriceEditState> {
  ProductPriceEditViewModel(super.initialState);

  void changePriceProduct({
    required Set<ProductModel> changeList,
    required double value,
    required PriceOperations operations,
  }) {
    final changeResult = PriceEditing.findAndOperate(
      value: value,
      operations: operations,
      mainList: state.mainList,
      selectedList: changeList,
    );
    emit(
      state.copyWith(
        mainList: changeResult.mainChangeList,
        selectedChangeList: changeResult.selectedChangeList,
      ),
    );
  }

  void selectAllProducts(bool isSelected) {
    emit(
      state.copyWith(
        selectedList: isSelected ? state.mainList.toSet() : {},
        allSelected: isSelected,
      ),
    );
  }

  void selectProduct(ProductModel product) {
    final selectedList = Set<ProductModel>.from(state.selectedList);
    if (selectedList.contains(product)) {
      selectedList.remove(product);
    } else {
      selectedList.add(product);
    }
    emit(
      state.copyWith(
        selectedList: selectedList,
        allSelected: selectedList.length == state.mainList.length,
      ),
    );
  }
}
