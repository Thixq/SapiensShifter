import 'package:core/core.dart';

import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/tables/view_model/state/tables_view_state.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
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

  Future<void> initial() async {
    await getBranchName;
    await getTableList;
  }

  Future<void> get getBranchName async {
    final workingStatus = _profile.sessionState.workingStatus;
    final branchName = await _profile.getToDayBranchName;
    _handleWorkingStatus(
      workingStatus: workingStatus,
      onWorking: () => state.copyWith(
        isWorking: true,
        branchName: branchName.sapiExt.textLocale(LocalizationPathEnum.branch),
      ),
    );
  }

  Future<void> get getTableList async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final workingStatus = _profile.sessionState.workingStatus;
        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.tableOpenTableColPath(
            _profile.sessionState.todayBranchId,
          ),
          model: const TableModel(),
        );
        _handleWorkingStatus(
          workingStatus: workingStatus,
          onWorking: () => state.copyWith(
            tableList: result,
            isLoading: false,
          ),
        );
      },
      customLogger: CustomLogger('TablesViewModel'),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => <TableModel>[],
    );
  }

  Future<void> deleteTable(TableModel table) async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final closedTable = table.copyWith(status: false);
        final branchId = _profile.sessionState.todayBranchId;
        await _networkManager.networkOperation.update(
          path: QueryPathConstant.tableOpenTableColPath(branchId ?? ''),
          value: {'status': false},
        );
        state.tableList.remove(closedTable);
        emit(
          state.copyWith(
            tableList: state.tableList,
          ),
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  void _handleWorkingStatus({
    required TablesViewState Function() onWorking,
    required WorkingStatusEnum workingStatus,
  }) {
    switch (workingStatus) {
      case WorkingStatusEnum.WORKING:
        emit(onWorking());
        return;
      case WorkingStatusEnum.OFF_DAY:
        emit(
          state.copyWith(
            isWorking: false,
            notWorkingMessage: LocaleKeys.user_working_state_off_day.tr(),
            tableList: [],
            branchName: '',
            isLoading: false,
          ),
        );
        return;
      case WorkingStatusEnum.UNASSIGNED:
        emit(
          state.copyWith(
            isWorking: false,
            notWorkingMessage: LocaleKeys.user_working_state_empty_day.tr(),
            tableList: [],
            branchName: '',
            isLoading: false,
          ),
        );
        return;
    }
  }
}
