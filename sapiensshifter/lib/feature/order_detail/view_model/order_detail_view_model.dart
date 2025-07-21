import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/order_detail/view_model/state/order_detail_state.dart';
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

class OrderDetailViewModel extends BaseCubit<OrderDetailState> {
  OrderDetailViewModel(
    super.initialState, {
    required INetworkManager networkManager,
  }) : _networkManager = networkManager;

  final INetworkManager _networkManager;

  Future<void> getExtras({
    required List<String>? optionsId,
  }) async {
    final query = optionsId == null
        ? null
        : FirebaseFirestoreCustomQuery(
            filters: [
              FilterCondition(
                field: 'id',
                value: optionsId,
                operator: FilterOperator.whereIn,
              ),
            ],
          );
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        if (optionsId == null) return [];

        final result = await _networkManager.networkOperation.getItemsQuery(
          path: QueryPathConstant.extras,
          model: const ExtrasModel(),
          query: query,
        );
        emit(state.copyWith(extrasList: result));
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
      customLogger: CustomLogger('OrderDetailViewModel'),
    );
  }

  void totalPriceAndOptionsList(
    double previousprice,
    double currentPrice,
    ExtrasModel extraModel,
    String optionName,
  ) {
    _calTotalPrice(currentPrice: currentPrice, previousprice: previousprice);
    _changeOption(extraModel: extraModel, optionName: optionName);
  }

  void _calTotalPrice({
    required double previousprice,
    required double currentPrice,
  }) {
    final result = currentPrice - previousprice;
    emit(
      state.copyWith(
        order: state.order.copyWith(price: (state.order.price ?? 0) + result),
      ),
    );
  }

  void _changeOption({
    required ExtrasModel extraModel,
    required String optionName,
  }) {
    state.selecetedOptions[extraModel] = optionName;
    emit(state);
  }

  void changeDelivery(DeliveryStatus delivery) {
    emit(state.copyWith(order: state.order.copyWith(deliveryStatus: delivery)));
  }

  OrderModel get sumbit {
    return state.order.copyWith(extras: state.selecetedOptions.values.toList());
  }
}
