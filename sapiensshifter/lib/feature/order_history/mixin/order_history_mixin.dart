part of '../view/order_history_view.dart';

mixin OrderHistoryMixin on BaseState<OrderHistoryView> {
  late final OrderHistoryViewModel _historyViewModel;

  OrderHistoryViewModel get viewModel => _historyViewModel;

  @override
  void initState() {
    _historyViewModel = OrderHistoryViewModel(
      OrderHistoryState.inital(),
      networkManager: ProductConfigureItems.networkManager,
      profile: ProductConfigureItems.profile,
    );
    _historyViewModel.listenTables();
    super.initState();
  }

  @override
  void dispose() {
    _historyViewModel.dispose();
    super.dispose();
  }
}
