import 'dart:collection' show SplayTreeMap;

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/menu/view_model/state/menu_view_state.dart';
import 'package:sapiensshifter/product/models/categories_model.dart';
import 'package:sapiensshifter/product/models/order_model.dart';
import 'package:sapiensshifter/product/models/product_model.dart';

class MenuViewModel extends BaseCubit<MenuViewState> {
  MenuViewModel(super.initialState, {required INetworkManager networkManager})
      : _networkManager = networkManager;

  final INetworkManager _networkManager;

  Future<List<T>> getProducts<T extends IBaseModel<T>>({
    required String path,
    required T item,
    INetworkQuery? query,
  }) async {
    return ErrorUtil.runWithErrorHandling(
      action: () async {
        return _networkManager.networkOperation.getItemsQuery<T>(
          path: path,
          query: query,
          model: item,
        );
      },
      customLogger: CustomLogger('menuLogger'),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: [],
    );
  }

  Future<void> getCategories() async {
    final categories = SplayTreeMap<String, String>();
    final result = await getProducts<CategoriesModel>(
      path: '/categories',
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
      path: '/products',
      item: const ProductModel(),
      query: newQuery != '0' ? query : null,
    );
    emit(state.copyWith(productList: result, isLoading: false));
  }

  void addOrder({required OrderModel order}) {
    final newTable =
        state.table.copyWith(orderList: [...state.table.orderList, order]);
    emit(state.copyWith(table: newTable));
  }
}
