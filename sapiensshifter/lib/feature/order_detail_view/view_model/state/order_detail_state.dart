// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model.dart';

final class OrderDetailState {
  OrderDetailState({
    required this.selecetedOptions,
    required this.order,
  });

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
