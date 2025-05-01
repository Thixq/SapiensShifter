import 'package:core/core.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/tables/view_model/state/tables_view_state.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';

class TablesViewModel extends BaseCubit<TablesViewState> {
  TablesViewModel({
    required this.profile,
    required INetworkManager networkManager,
  })  : _networkManager = networkManager,
        super(TablesViewState.initial());

  final INetworkManager _networkManager;
  final Profile profile;

  Future<void> get getTableList async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await ErrorUtil.runWithErrorHandlingAsync<List<TableModel>>(
      action: () async {
        final branchId = await profile.getToDayBranchId;
        return _networkManager.networkOperation.getItemsQuery(
          path: '${QueryPathConstant.tableColPath}/$branchId/open',
          model: const TableModel(),
        );
      },
      customLogger: CustomLogger('TablesViewModel'),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => <TableModel>[],
    );
    emit(
      state.copyWith(
        tableList: result,
        isLoading: false,
      ),
    );
  }

  Future<void> deleteTable(TableModel table) async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final closedTable = table.copyWith(status: false);
        final branchId = await profile.getToDayBranchId;
        await _networkManager.networkOperation.update(
          path: '${QueryPathConstant.tableColPath}/$branchId/open/${table.id}',
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
      fallbackValue: () {
        emit(
          state.copyWith(
            isLoading: false,
            tableList: state.tableList,
          ),
        );
        return null;
      },
    );
  }
}
