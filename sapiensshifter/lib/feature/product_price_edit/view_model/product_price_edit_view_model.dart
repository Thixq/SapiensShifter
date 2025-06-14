// ignore_for_file: avoid_positional_boolean_parameters

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model_mixin/iterable_operation_mixin.dart';
import 'package:sapiensshifter/feature/product_price_edit/view_model/state/product_price_edit_state.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/price_ration_model/price_ration_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/enums/operations.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/static_func/price_editing.dart';

class ProductPriceEditViewModel extends BaseCubit<ProductPriceEditState>
    with PriceIterableOperationMixin<ProductPriceEditState> {
  ProductPriceEditViewModel(
    super.initialState, {
    required INetworkManager networkManager,
  }) : _networkManager = networkManager;

  final INetworkManager _networkManager;

  Future<List<T>> _getItems<T extends IBaseModel<T>>({
    required String path,
    required T itemModel,
    INetworkQuery? query,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync<List<T>>(
      action: () async {
        return _networkManager.networkOperation
            .getItemsQuery(query: query, path: path, model: itemModel);
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => [],
    );
  }

  Future<void> initial() async {
    emit(state.copyWith(isLoading: true));
    await getCategories();
    await getPriceRations();
    emit(state.copyWith(isLoading: false));
    await getProducts();
  }

  Future<void> getCategories() async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'id')],
    );

    final result = await _getItems(
      path: QueryPathConstant.categoryColPath,
      query: query,
      itemModel: const CategoriesModel(),
    );

    final categoryMap = {
      for (final item in result)
        item.name.sapiExt.textLocale(LocalizationPathEnum.category):
            item.id ?? '-1',
    };
    emit(state.copyWith(categories: categoryMap));
  }

  Future<void> getPriceRations() async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'value')],
    );
    final result = await _getItems(
      path: QueryPathConstant.priceRationColPath,
      query: query,
      itemModel: PriceRationModel(),
    );

    final priceRationMap = {
      for (final item in result)
        item.name.sapiExt.textLocale(LocalizationPathEnum.priceRation): item,
    };
    emit(state.copyWith(priceRations: priceRationMap));
  }

  Future<void> getProducts() async {
    final result = await _getItems(
      path: QueryPathConstant.productsColPath,
      itemModel: const ProductModel(),
    );

    emit(
      state.copyWith(
        mainList: result,
        originalList: result,
        filteredList: result,
      ),
    );
  }

  void changeCategory({required String categoryId}) {
    if (categoryId == StringConstant.allCategoryId) {
      final mainList = state.mainList;
      emit(state.copyWith(filteredList: mainList));
      return;
    }

    final filteredList = state.mainList
        .where(
          (element) => element.category == categoryId,
        )
        .toList();
    emit(state.copyWith(filteredList: filteredList));
  }

  void changePriceProduct({
    required double value,
    required PriceOperations operations,
  }) {
    if (value == StringConstant.allPirceOperationValue) {
      emit(
        state.copyWith(
          mainList: state.originalList,
          filteredList: state.originalList,
          selectedList: {},
          selectedChangeList: {},
          allSelected: false,
        ),
      );
      return;
    }
    final changeResult = PriceEditing.findAndOperate(
      value: value,
      operations: operations,
      mainList: state.mainList,
      selectedList: state.selectedList,
    );
    syncListFromSet(
      changeResult.selectedChangeList,
      state.selectedChangeList,
    );
    syncListFromList(changeResult.mainChangeList, state.filteredList);
    emit(
      state.copyWith(
        mainList: changeResult.mainChangeList,
        filteredList: changeResult.mainChangeList,
        selectedList: {},
        allSelected: false,
      ),
    );
  }

  void selectAllProducts(bool isSelected) {
    emit(
      state.copyWith(
        selectedList: isSelected ? state.filteredList.toSet() : {},
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
