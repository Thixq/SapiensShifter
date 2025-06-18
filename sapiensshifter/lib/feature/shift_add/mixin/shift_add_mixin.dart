import 'package:flutter/cupertino.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift_add/view/shift_add_view.dart';
import 'package:sapiensshifter/feature/shift_add/view_model/shift_add_view_model.dart';
import 'package:sapiensshifter/feature/shift_add/view_model/state/shift_add_state.dart';

mixin ShiftAddMixin on BaseState<ShiftAddView> {
  late final ShiftAddViewModel _shiftAddViewModel;
  ShiftAddViewModel get viewModel => _shiftAddViewModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _shiftAddViewModel = ShiftAddViewModel(
      ShiftAddState.initial(),
      networkManager: ProductConfigureItems.networkManager,
    );
    _shiftAddViewModel.initial();
    super.initState();
  }
}
