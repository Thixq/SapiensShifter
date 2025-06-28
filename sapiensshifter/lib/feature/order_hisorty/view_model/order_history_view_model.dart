import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/order_hisorty/view_model/state/order_history_state.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class OrderHistoryViewModel extends BaseCubit<OrderHistoryState> {
  OrderHistoryViewModel(
    super.initialState, {
    required INetworkManager networkManager,
    required Profile profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;
  late final StreamSubscription<List<TableModel>> _streamSubscription;

  Future<void> getTable() async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        emit(state.copyWith(isLoading: true));
        await _getHistoryTable();
        await _getNewTableStream();
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  Future<void> _getHistoryTable() async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [
        OrderByCondition(field: 'timeStamp'),
      ],
    );

    final branchId = _profile.user?.toDayBranch;
    final path = QueryPathConstant.tableOpenTableColPath(branchId ?? '');
    final historyTables = await _networkManager.networkOperation
        .getItemsQuery(path: path, model: const TableModel(), query: query);
    emit(state.copyWith(tables: historyTables, isLoading: false));
  }

  Future<void> _getNewTableStream() async {
    _streamSubscription = _getTableStream.listen(
      (tableItems) {
        if (tableItems.isNotEmpty) {
          state.tables.add(tableItems.last);
          emit(state.copyWith());
        }
      },
    );
  }

  Stream<List<TableModel>> get _getTableStream async* {
    final query = FirebaseFirestoreCustomQuery(
      filters: [
        FilterCondition(
          field: 'timeStamp',
          value: state.tables.last.toJson()['timeStamp'],
          operator: FilterOperator.isGreaterThan,
        ),
      ],
    );

    final branchId = _profile.user?.toDayBranch;
    final tableStream = _networkManager.networkOperation.getStreamQuery(
      path: QueryPathConstant.tableOpenTableColPath(branchId ?? ''),
      model: const TableModel(),
      query: query,
    );
    yield* tableStream;
  }

  Future<bool> orderClose({
    required String tableId,
    required String orderId,
  }) async {
    final branchId = _profile.user?.toDayBranch;
    final path =
        '${QueryPathConstant.tableOpenTableColPath(branchId ?? '')}/$tableId';
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation
            .getItem(path: path, model: const TableModel());

        final changeOrderList = result.orderList.map(
          (order) {
            if (order.id == orderId) {
              return order.copyWith(status: false);
            }
            return order;
          },
        ).toList();

        return _networkManager.networkOperation.update(
          path: path,
          value: {
            'orderList': changeOrderList
                .map(
                  (order) => order.toJson(),
                )
                .toList(),
          },
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  Future<bool> tableClose({required String tableId}) async {
    final branchId = _profile.user?.toDayBranch;
    final path =
        '${QueryPathConstant.tableOpenTableColPath(branchId ?? '')}/$tableId';

    state.tables.removeWhere(
      (element) => element.id == tableId,
    );
    emit(state.copyWith());
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        return _networkManager.networkOperation
            .update(path: path, value: {'status': false});
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}
