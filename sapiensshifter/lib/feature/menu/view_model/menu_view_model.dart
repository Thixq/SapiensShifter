import 'dart:collection' show SplayTreeMap;

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/menu/view_model/state/menu_view_state.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class MenuViewModel extends BaseCubit<MenuViewState> {
  MenuViewModel(
    super.initialState, {
    required this.currentUser,
    required INetworkManager networkManager,
  }) : _networkManager = networkManager;

  final INetworkManager _networkManager;
  final Profile currentUser;
  final _menuLogger = CustomLogger('menuLogger');

  Future<List<T>> getProducts<T extends IBaseModel<T>>({
    required String path,
    required T item,
    INetworkQuery? query,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        return _networkManager.networkOperation.getItemsQuery<T>(
          path: path,
          query: query,
          model: item,
        );
      },
      customLogger: _menuLogger,
      errorHandler: ServiceErrorHandler(),
      fallbackValue: [],
    );
  }

  Future<bool> writeDatabaseTable() async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final table = state.table;
        final branchId = await currentUser.getToDayBranchId;
        await _networkManager.networkOperation.addItem<TableModel>(
          path: '${QueryPathConstant.tableColPath}/$branchId/open',
          item: table,
        );
        return true;
      },
      customLogger: _menuLogger,
      errorHandler: ServiceErrorHandler(),
      fallbackValue: false,
    );
  }

  Future<void> getCategories() async {
    final categories = SplayTreeMap<String, String>();
    final result = await getProducts<CategoriesModel>(
      path: QueryPathConstant.categoryColPath,
      item: CategoriesModel(),
    );

    categories.addEntries(
      result.map(
        (e) => MapEntry<String, String>(e.name!, e.id!),
      ),
    );

    emit(state.copyWith(categories: categories));
  }

  Future<void> changeCategory(String newQuery) async {
    emit(state.copyWith(isLoading: true));
    final query = FirebaseFirestoreCustomQuery(
      filters: [FilterCondition(field: 'category', value: newQuery)],
    );
    final result = await getProducts<ProductModel>(
      path: QueryPathConstant.productsColPath,
      item: const ProductModel(),
      query: newQuery != '0' ? query : null,
    );
    emit(state.copyWith(productList: result, isLoading: false));
  }

  void addOrder({OrderModel? order}) {
    if (order != null) {
      final newTable =
          state.table.copyWith(orderList: [...state.table.orderList, order]);
      emit(state.copyWith(table: newTable));
    }
  }
}
