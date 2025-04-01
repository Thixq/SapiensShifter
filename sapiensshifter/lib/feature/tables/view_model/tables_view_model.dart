import 'package:core/core.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/table_export.dart';

class TablesViewModel {
  TablesViewModel({required INetworkManager networkManager})
      : _networkManager = networkManager;

  final INetworkManager _networkManager;

  Future<List<TableModel>> get getTableList async {
    final result = await ErrorUtil.runWithErrorHandling<List<TableModel>>(
      action: () async {
        return _networkManager.networkOperation.getItemsQuery(
          path: 'table/kanyon/open',
          model: const TableModel(),
        );
      },
      customLogger: CustomLogger('TablesViewModel'),
      errorHandler: ServiceErrorHandler(),
      fallbackValue: const [],
    );
    return result;
  }
}
