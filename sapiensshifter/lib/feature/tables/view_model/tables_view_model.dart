import 'package:core/core.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/tables/view_model/state/tables_view_state.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
// Yeni import'umuz:

import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/enums/working_status_state.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

class TablesViewModel extends BaseCubit<TablesViewState> {
  TablesViewModel(
    super.initialState, {
    required Profile profile,
    required INetworkManager networkManager,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;

  // `getBranchName` ve `getTableList` birleştirildi. `initial` artık tek sorumlu.
  Future<void> initial() async {
    setInitialWorkingStatus();
    await fetchTables();
  }

  void setInitialWorkingStatus() {
    _profile.sessionState.workingStatus.map<void>(
      onWorking: (working) {
        emit(
          state.copyWith(
            isWorking: true,
            branchName: working.branchName.sapiExt
                .textLocale(LocalizationPathEnum.branch),
          ),
        );
      },
      onOffDay: (offDay) {
        emit(
          state.copyWith(
            isWorking: false,
            notWorkingMessage: offDay.reason,
            branchName: '',
          ),
        );
      },
      onUnassigned: (unassigned) {
        emit(
          state.copyWith(
            isWorking: false,
            notWorkingMessage: unassigned.reason,
            branchName: '',
          ),
        );
      },
    );
  }

  Future<void> fetchTables() async {
    final workingStatus = _profile.sessionState.workingStatus;
    if (workingStatus is! Working) {
      emit(state.copyWith(isLoading: false, tableList: []));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final branchId = workingStatus.branchId;

    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final tableList = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.tableOpenTableColPath(branchId),
          model: const TableModel(),
        );

        emit(
          state.copyWith(
            tableList: tableList,
            isLoading: false,
          ),
        );
      },
      customLogger: CustomLogger('TablesViewModel-fetchTables'),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async =>
          emit(state.copyWith(isLoading: false, tableList: [])),
    );
  }

  // YENİ `deleteTable` METODU
  Future<void> deleteTable(TableModel table) async {
    final status = _profile.sessionState.workingStatus;

    if (status is! Working) {
      return;
    }
    final branchId = status.branchId;

    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final closedTable = table.copyWith(status: false);
        await _networkManager.networkOperation.update(
          path: QueryPathConstant.tableOpenTableColPath(
            branchId,
          ),
          value: {
            'status': false,
          },
        );

        final updatedList = List<TableModel>.from(state.tableList)
          ..remove(closedTable);
        emit(
          state.copyWith(tableList: updatedList),
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }
}
