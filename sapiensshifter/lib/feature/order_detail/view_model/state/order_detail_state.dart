import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';

final class OrderDetailState {
  OrderDetailState({
    required this.selecetedOptions,
    required this.order,
  });

  factory OrderDetailState.initial({required OrderModel order}) {
    return OrderDetailState(
      selecetedOptions: {},
      order: order,
    );
  }

  final Map<ExtrasModel, String> selecetedOptions;
  final OrderModel order;

  OrderDetailState copyWith({
    Map<ExtrasModel, String>? selecetedOptions,
    OrderModel? order,
  }) {
    return OrderDetailState(
      selecetedOptions: selecetedOptions ?? this.selecetedOptions,
      order: order ?? this.order,
    );
  }
}
