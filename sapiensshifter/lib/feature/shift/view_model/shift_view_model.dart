import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/shift/view_model/state/shift_view_state.dart';

import 'package:sapiensshifter/product/shift_manager/shift_manager.dart';

class ShiftViewModel extends BaseCubit<ShiftViewState> {
  ShiftViewModel(
    super.initialState, {
    required ShiftManager shiftManager,
  }) : _shiftManager = shiftManager;

  final ShiftManager _shiftManager;

  Future<void> initial({required DateTime firstWeekFirstDay}) async {
    await getShiftStatus();
    await getBranch();
    await getShift(firstWeekFirstDay: firstWeekFirstDay);
  }

  Future<void> getBranch() async {
    final result = await _shiftManager.getBranchs();

    final mappedBranch = Map.fromEntries(
      result.map(
        (branch) => MapEntry(branch.id ?? '-1', branch),
      ),
    );
    emit(state.copyWith(branchs: mappedBranch));
  }

  Future<void> getShiftStatus() async {
    final result = await _shiftManager.getShiftStatus();
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
        final shiftList =
            await _shiftManager.getShifts(firstWeekFirstDay: firstWeekFirstDay);

        emit(state.copyWith(shifts: shiftList));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }
}
