import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/shift_add/view_model/state/shift_add_state.dart';
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/models/week_period/week_period.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

class ShiftAddViewModel extends BaseCubit<ShiftAddState> {
  ShiftAddViewModel(
    super.initialState, {
    required INetworkManager networkManager,
  }) : _networkManager = networkManager;

  final INetworkManager _networkManager;

  Future<void> initial() async {
    await getPeoples();
    await getBranchs();
    await getShifts();
  }

  void addDay({required ShiftDay day, required int index}) {
    final shiftDate = state.week.weekStart?.add(Duration(days: index));
    state.shiftMap[index] = day.copyWith(time: shiftDate);
  }

  void shiftWeek({required WeekPeriod weekPeriod}) {
    emit(
      state.copyWith(
        week: state.week
            .copyWith(weekStart: weekPeriod.start, weekEnd: weekPeriod.end),
        shiftMap: state.shiftMap.map(
          (key, value) {
            return MapEntry(
              key,
              value.copyWith(time: weekPeriod.start.add(Duration(days: key))),
            );
          },
        ),
      ),
    );
  }

  Future<bool> shiftAdd({required String peopleId}) async {
    _weekIdGenerator();
    final path =
        '${QueryPathConstant.shiftsColPath(peopleId)}/${state.week.id}';
    return ErrorUtil.runWithErrorHandlingAsync<bool>(
      action: () async {
        final shiftWeek =
            state.week.copyWith(week: state.shiftMap.values.toList());
        final result = await _networkManager.networkOperation
            .addItem(path: path, item: shiftWeek);
        return result;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }

  void _weekIdGenerator() {
    final buffer = StringBuffer()
      ..write(state.week.weekStart)
      ..write(state.week.weekEnd);
    emit(state.copyWith(week: state.week.copyWith(id: buffer.toString())));
  }

  Future<void> getPeoples() async {
    final peoples = await _getItems(
      path: QueryPathConstant.usersPreviewColPath,
      itemModel: UserPreviewModel(),
    );
    final mappedPeoples = Map.fromEntries(
      peoples.map(
        (people) => MapEntry(people.name ?? '-1', people.userId ?? '-1'),
      ),
    );
    emit(state.copyWith(peoples: mappedPeoples));
  }

  Future<void> getBranchs() async {
    final peoples = await _getItems(
      path: QueryPathConstant.branchColPath,
      itemModel: BranchModel(),
    );
    final mappedBranchs = Map.fromEntries(
      peoples.map(
        (people) => MapEntry(people.name ?? '-1', people.id ?? '-1'),
      ),
    );
    emit(state.copyWith(branchs: mappedBranchs));
  }

  Future<void> getShifts() async {
    final peoples = await _getItems(
      path: QueryPathConstant.shiftStatusColPath,
      itemModel: ShiftStatusModel(),
    );
    final mappedShifts = Map.fromEntries(
      peoples.map(
        (people) => MapEntry(
          people.status?.localization.tr() ?? '-1',
          people.id ?? '-1',
        ),
      ),
    );
    emit(state.copyWith(shifts: mappedShifts));
  }

  Future<List<T>> _getItems<T extends IBaseModel<T>>({
    required String path,
    required T itemModel,
    INetworkQuery? query,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync<List<T>>(
      action: () async {
        return _networkManager.networkOperation
            .getItemsQuery(query: query, path: path, model: itemModel);
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => [],
    );
  }
}
