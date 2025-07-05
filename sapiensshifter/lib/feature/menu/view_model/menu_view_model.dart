import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/constant/string_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/menu/view_model/state/menu_view_state.dart';
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/enums/working_status_state.dart';

class MenuViewModel extends BaseCubit<MenuViewState> {
  MenuViewModel(
    super.initialState, {
    required Profile profile,
    required INetworkManager networkManager,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;
  final _menuLogger = CustomLogger('menuLogger');

  Future<bool> writeDatabaseTable() async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final status = _profile.sessionState.workingStatus;

        if (status is! Working) {
          _menuLogger.warning(
            'Çalışma durumu dışındayken masa açılmaya/güncellenmeye çalışıldı.',
          );

          return false;
        }

        // 3. Artık 'status' değişkeninin 'Working' olduğunu biliyoruz.
        // `branchId`'ye güvenle erişebiliriz.
        final branchId = status.branchId;
        final table = state.table;

        // Veritabanı yolu artık güvenli. Null kontrolüne gerek yok.
        final path =
            '${QueryPathConstant.tableColPath}/$branchId/open/${table.id}';

        await _networkManager.networkOperation.addItem<TableModel>(
          path: path,
          item: table,
        );

        return true;
      },
      customLogger: _menuLogger,
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

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
      fallbackValue: () async => [],
    );
  }

  Future<void> getCategories() async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'id')],
    );

    emit(state.copyWith(isLoadingCategories: true));
    final result = await getProducts<CategoriesModel>(
      path: QueryPathConstant.categoryColPath,
      item: const CategoriesModel(),
      query: query,
    );

    emit(state.copyWith(categories: result, isLoadingCategories: false));
  }

  Future<void> changeCategory(String newQuery) async {
    emit(state.copyWith(isLoading: true));
    final query = FirebaseFirestoreCustomQuery(
      filters: [FilterCondition(field: 'category', value: newQuery)],
    );
    final result = await getProducts<ProductModel>(
      path: QueryPathConstant.productsColPath,
      item: const ProductModel(),
      query: newQuery != StringConstant.allCategoryId ? query : null,
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
