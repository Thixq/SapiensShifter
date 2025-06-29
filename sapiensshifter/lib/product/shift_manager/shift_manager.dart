// ignore_for_file: avoid_setters_without_getters, prefer_constructors_over_static_methods

import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/models/branch_model/branch_model.dart';
import 'package:sapiensshifter/product/models/shift_models/shift_day_model.dart';
import 'package:sapiensshifter/product/models/shift_models/shift_status_model/shift_status_model.dart';
import 'package:sapiensshifter/product/models/shift_models/shift_week_model.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/mixin/func/month_full_weeks.dart';

class ShiftManager {
  ShiftManager._({
    required Profile profile,
    required INetworkManager networkManager,
  })  : _profile = profile,
        _networkManager = networkManager;

  final Profile _profile;
  final INetworkManager _networkManager;

  static ShiftManager instanceFor({
    required Profile profile,
    required INetworkManager networkManager,
  }) =>
      ShiftManager._(profile: profile, networkManager: networkManager);

  List<ShiftDay>? _allShift;

  List<ShiftDay>? get allShift => _allShift;

  ShiftDay? get toDayBranch => _allShift?.firstWhere(
        (shiftDay) => DateUtils.isSameDay(shiftDay.time, DateTime.now()),
      );

  set _changeShifts(List<ShiftDay>? newShifts) {
    _allShift = newShifts;
  }

  Future<void> reload({DateTime? firstWeekFirstDay}) async {
    final firstDay = MonthFullWeeksMixin()
        .getCurrentMonthFullWeeksRange(date: firstWeekFirstDay)
        .start;
    final result = await getShifts(firstWeekFirstDay: firstDay);
    _changeShifts = result;
  }

  Future<List<ShiftStatusModel>> getShiftStatus() async {
    final result = await _getItems(
      path: QueryPathConstant.shiftStatusColPath,
      model: ShiftStatusModel(),
    );

    return result;
  }

  Future<List<BranchModel>> getBranchs() async {
    final result = await _getItems(
      path: QueryPathConstant.branchColPath,
      model: BranchModel(),
    );

    return result;
  }

  Future<List<ShiftDay>> getShifts({
    required DateTime firstWeekFirstDay,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result =
            await _getShiftWeeks(firstWeekFirstDay: firstWeekFirstDay);

        final shiftAndBranch = await _getBranchAndShiftMaps();

        final shiftList = result
            .expand((element) => element.week ?? <ShiftDay>[])
            .map((shift) {
          final shiftStatusModel = shiftAndBranch.shiftMap[shift.shiftStatusId];
          final branch = shiftAndBranch.branchMap[shift.branchId];
          return shift.copyWith(
            branchName: branch?.name,
            shiftStatus: shiftStatusModel,
          );
        }).toList();
        return shiftList;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => [],
    );
  }

  Future<
      ({
        Map<String, BranchModel> branchMap,
        Map<String, ShiftStatusModel> shiftMap
      })> _getBranchAndShiftMaps() async {
    final shiftStatus = await getShiftStatus();
    final branchs = await getBranchs();

    final mappedBranch = Map.fromEntries(
      branchs.map(
        (branch) => MapEntry(branch.id ?? '-1', branch),
      ),
    );

    final mappedShiftStatus = Map.fromEntries(
      shiftStatus.map(
        (shiftStatus) => MapEntry(shiftStatus.id ?? '-1', shiftStatus),
      ),
    );
    return (branchMap: mappedBranch, shiftMap: mappedShiftStatus);
  }

  Future<List<ShiftWeek>> _getShiftWeeks({
    required DateTime firstWeekFirstDay,
    int? startAt = 6,
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
      limit: startAt,
    );
    final result = await _getItems(
      path: QueryPathConstant.shiftsColPath(_profile.user?.id ?? '-1'),
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
      fallbackValue: () async => [],
    );
  }
}
