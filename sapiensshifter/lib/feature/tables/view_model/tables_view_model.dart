import 'package:core/core.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/tables/view_model/state/tables_view_state.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';
import 'package:sapiensshifter/product/utils/extensions/string_extension.dart';

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
    final result = await _profile.getToDayBranch;
    if (result != null && result.isNotEmpty) {
      emit(
        state.copyWith(
          emptyBracnh: false,
          branchName: result.sapiExt.textLocale(LocalizationPathEnum.branch),
        ),
      );
      return;
    }
    emit(state.copyWith(emptyBracnh: true));
  }

  Future<void> get getTableList async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final branchId = _profile.user?.toDayBranch;
        if (branchId == null || branchId.isEmpty) {
          emit(
            state.copyWith(isLoading: false, tableList: []),
          );
          return;
        }
        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.tableOpenTableColPath(branchId),
          model: const TableModel(),
        );
        emit(
          state.copyWith(
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
        final branchId = _profile.user?.toDayBranch;
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
}
