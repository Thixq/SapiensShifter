import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/constant/query_path_constant.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';

class ShiftViewModel {
  ShiftViewModel({
    required INetworkManager networkManager,
    required Profile profile,
  })  : _networkManager = networkManager,
        _profile = profile;

  final INetworkManager _networkManager;
  final Profile _profile;

  Future<List<ShiftDay>> getShift() async {
    final query = FirebaseFirestoreCustomQuery(
      orderBy: [OrderByCondition(field: 'weekStart')],
      limitToLast: 5,
    );

    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final shiftList = <ShiftDay>[];
        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.shiftsColPath(_profile.user?.id ?? 'null'),
          model: const ShiftWeek(),
          query: query,
        );
        for (final element in result) {
          for (final shift in element.week ?? <ShiftDay>[]) {
            shiftList.add(shift);
          }
        }

        return shiftList;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: [],
    );
  }
}
