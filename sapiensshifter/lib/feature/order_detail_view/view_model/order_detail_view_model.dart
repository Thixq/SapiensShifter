import 'package:core/core.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/order_detail_view/view_model/state/order_detail_state.dart';
import 'package:sapiensshifter/product/models/extras_model.dart';
import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

class OrderDetailViewModel extends BaseCubit<OrderDetailState> {
  OrderDetailViewModel(
    super.initialState, {
    required INetworkManager networkManager,
  }) : _networkManager = networkManager;

  final INetworkManager _networkManager;

  Future<List<ExtrasModel>> getExtras({
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
    return ErrorUtil.runWithErrorHandling<List<ExtrasModel>>(
      action: () async {
        if (optionsId == null) return [];

        return _networkManager.networkOperation.getItemsQuery(
          path: '/extras',
          model: const ExtrasModel(),
          query: query,
        );
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: [],
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

  void sumbit() {
    emit(
      state.copyWith(
        order: state.order
            .copyWith(extras: state.selecetedOptions.values.toList()),
      ),
    );

    print(state.order);
  }
}
