import 'package:core/core.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/shift_add/view_model/state/shift_add_state.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/models/week_period/week_period.dart';
import 'package:sapiensshifter/product/shift_manager/shift_manager.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

class ShiftAddViewModel extends BaseCubit<ShiftAddState> {
  ShiftAddViewModel(
    super.initialState, {
    required INetworkManager networkManager,
    required ShiftManager shiftManager,
  })  : _networkManager = networkManager,
        _shiftManager = shiftManager;

  final INetworkManager _networkManager;
  final ShiftManager _shiftManager;

  Future<void> initial() async {
    await getPeoples();
    await getBranchs();
    await getShiftsStatus();
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

    emit(state.copyWith(peoples: peoples));
  }

  Future<void> getBranchs() async {
    final result = await _shiftManager.getBranchs();
    emit(state.copyWith(branchs: result));
  }

  Future<void> getShiftsStatus() async {
    final result = await _shiftManager.getShiftStatus();
    emit(state.copyWith(shifts: result));
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
