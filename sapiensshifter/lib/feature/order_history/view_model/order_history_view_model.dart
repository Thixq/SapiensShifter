import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/order_history/view_model/state/order_history_state.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/enums/working_status_state.dart';

class OrderHistoryViewModel extends BaseCubit<OrderHistoryState> {
  OrderHistoryViewModel(
    super.initialState, {
    required INetworkManager networkManager,
    required Profile profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;

  StreamSubscription<List<TableModel>>? _streamSubscription;

  Future<void> listenTables() async {
    await _streamSubscription?.cancel();
    emit(
      state.copyWith(isLoading: true, tables: []),
    );

    _profile.sessionState.workingStatus.map(
      onWorking: (working) {
        emit(state.copyWith(isWorking: true));
        final branchId = working.branchId;

        _streamSubscription = _getTableStream(branchId: branchId).listen(
          (tableItems) {
            emit(
              state.copyWith(
                tables: tableItems,
                isLoading: false,
              ),
            );
          },
          onError: (error) {
            emit(state.copyWith(isLoading: false));
          },
        );
      },
      onOffDay: (offDay) {
        emit(
          state.copyWith(
            isLoading: false,
            isWorking: false,
            notWorkingMessage: offDay.reason,
            tables: [],
          ),
        );
      },
      onUnassigned: (unassigned) {
        emit(
          state.copyWith(
            isLoading: false,
            isWorking: false,
            notWorkingMessage: 'Bugün için bir vardiyanız bulunmuyor.',
            tables: [],
          ),
        );
      },
    );
  }

  Stream<List<TableModel>> _getTableStream({String? branchId}) {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'timeStamp')],
    );

    return _networkManager.networkOperation.getStreamQuery(
      path: QueryPathConstant.tableOpenTableColPath(branchId),
      model: const TableModel(),
      query: query,
    );
  }

  Future<bool> orderClose({
    required String tableId,
    required String orderId,
  }) async {
    final status = _profile.sessionState.workingStatus;
    if (status is! Working) return false;

    final branchId = status.branchId;
    final openTablePath =
        '${QueryPathConstant.tableOpenTableColPath(branchId)}/$tableId';

    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation
            .getItem(path: openTablePath, model: const TableModel());

        final changeOrderList = result.orderList.map(
          (order) {
            if (order.id == orderId) {
              return order.copyWith(status: false);
            }
            return order;
          },
        ).toList();

        return _networkManager.networkOperation.update(
          path: openTablePath,
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
    final status = _profile.sessionState.workingStatus;
    if (status is! Working) return false;

    final branchId = status.branchId;
    final openTablePath =
        '${QueryPathConstant.tableOpenTableColPath(branchId)}/$tableId';
    final closeTablePath =
        '${QueryPathConstant.tableCloseTableColPath(branchId)}/$tableId';

    final removeTableList = List<TableModel>.from(state.tables)
      ..removeWhere(
        (element) => element.id == tableId,
      );

    emit(state.copyWith(tables: removeTableList));

    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        return _networkManager.networkOperation.runTransaction<bool>(
          (transaction) async {
            final result = await transaction.get(
              path: openTablePath,
              model: const TableModel(),
            );
            final closedTable = result.copyWith(
              closingTime: DateTime.now(),
              status: false,
              orderList: result.orderList
                  .map(
                    (order) => order.copyWith(status: false),
                  )
                  .toList(),
            );
            transaction
              ..set(path: closeTablePath, item: closedTable)
              ..delete(path: openTablePath);

            return true;
          },
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  void dispose() {
    _streamSubscription?.cancel();
  }
}
