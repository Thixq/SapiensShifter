import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/shift/view_model/state/shift_view_state.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

class ShiftViewModel extends BaseCubit<ShiftViewState> {
  ShiftViewModel(
    super.initialState, {
    required INetworkManager networkManager,
    required Profile profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;

  Future<void> initial({required DateTime firstWeekFirstDay}) async {
    await getShiftStatus();
    await getBranch();
    await getShift(firstWeekFirstDay: firstWeekFirstDay);
  }

  Future<void> getBranch() async {
    final result = await _getItems(
      path: QueryPathConstant.branchColPath,
      model: BranchModel(),
    );

    final mappedBranch = Map.fromEntries(
      result.map(
        (branch) => MapEntry(branch.id ?? '-1', branch),
      ),
    );
    emit(state.copyWith(branchs: mappedBranch));
  }

  Future<void> getShiftStatus() async {
    final result = await _getItems(
      path: QueryPathConstant.shiftStatusColPath,
      model: ShiftStatusModel(),
    );
    final mappedShiftStatus = Map.fromEntries(
      result.map(
        (shiftStatus) => MapEntry(shiftStatus.id ?? '-1', shiftStatus),
      ),
    );
    emit(state.copyWith(shiftStatus: mappedShiftStatus));
  }

  Future<void> getShift({required DateTime firstWeekFirstDay}) async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result =
            await _getShiftWeeks(firstWeekFirstDay: firstWeekFirstDay);

        final shiftList = result
            .expand((element) => element.week ?? <ShiftDay>[])
            .map((shift) {
          final shiftStatusModel = state.shiftStatus[shift.shiftStatusId];
          final branch = state.branchs[shift.branchId];
          return shift.copyWith(
            branchName: branch?.name,
            shiftStatus: shiftStatusModel,
          );
        }).toList();

        emit(state.copyWith(shifts: shiftList));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () {},
    );
  }

  Future<List<ShiftWeek>> _getShiftWeeks({
    required DateTime firstWeekFirstDay,
  }) async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'weekStart', descending: true)],
      filters: [
        FilterCondition(
          field: 'weekStart',
          value: firstWeekFirstDay,
          operator: FilterOperator.isGreaterThanOrEqualToDateTime,
        ),
      ],
      limit: 6,
    );
    final result = await _getItems(
      path: QueryPathConstant.shiftsColPath(_profile.user?.id ?? 'null'),
      model: const ShiftWeek(),
      query: query,
    );
    return result;
  }

  Future<List<T>> _getItems<T extends IBaseModel<T>>({
    required String path,
    required T model,
    INetworkQuery? query,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync<List<T>>(
      action: () async {
        return _networkManager.networkOperation
            .getItemsQuery(path: path, model: model, query: query);
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () => [],
    );
  }
}
