// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';

final class OrderDetailState {
  OrderDetailState({
    required this.extrasList,
    required this.selecetedOptions,
    required this.order,
  });

  factory OrderDetailState.initial({required OrderModel order}) {
    return OrderDetailState(
      extrasList: [],
      selecetedOptions: {},
      order: order,
    );
  }

  final List<ExtrasModel> extrasList;
  final Map<ExtrasModel, String> selecetedOptions;
  final OrderModel order;

  OrderDetailState copyWith({
    List<ExtrasModel>? extrasList,
    Map<ExtrasModel, String>? selecetedOptions,
    OrderModel? order,
  }) {
    return OrderDetailState(
      extrasList: extrasList ?? this.extrasList,
      selecetedOptions: selecetedOptions ?? this.selecetedOptions,
      order: order ?? this.order,
    );
  }
}
