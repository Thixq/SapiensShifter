import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/order_hisorty/view/order_history_view.dart';
import 'package:sapiensshifter/feature/order_hisorty/view_model/order_history_view_model.dart';
import 'package:sapiensshifter/feature/order_hisorty/view_model/state/order_history_state.dart';

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
    _historyViewModel.getTable();
    super.initState();
  }
}
