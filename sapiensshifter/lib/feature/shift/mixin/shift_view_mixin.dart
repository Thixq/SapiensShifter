import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift/view/shift_view.dart';
import 'package:sapiensshifter/feature/shift/view_model/shift_view_model.dart';

mixin ShiftViewMixin on BaseState<ShiftView> {
  final profile = ProductConfigureItems.profile;
  late final ShiftViewModel _shiftViewModel;
  ShiftViewModel get viewModel => _shiftViewModel;
  @override
  void initState() {
    _shiftViewModel = ShiftViewModel(
      networkManager: ProductConfigureItems.networkManager,
      profile: profile,
    );
    super.initState();
  }
}
