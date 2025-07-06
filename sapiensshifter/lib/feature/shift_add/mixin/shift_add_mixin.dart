part of '../view/shift_add_view.dart';

mixin ShiftAddMixin on BaseState<ShiftAddView> {
  late final ShiftAddViewModel _shiftAddViewModel;
  ShiftAddViewModel get viewModel => _shiftAddViewModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onConfrim(String? peopleId) {
    if (formKey.currentState?.validate() ?? false) {
      viewModel.shiftAdd(peopleId: peopleId ?? '-1');
      showSnakeToastMessage(
        context,
        message: LocaleKeys.page_sihft_add_view_show_toast_message.tr(),
      );
    }
  }

  @override
  void initState() {
    _shiftAddViewModel = ShiftAddViewModel(
      ShiftAddState.initial(),
      networkManager: ProductConfigureItems.networkManager,
      shiftManager: ProductConfigureItems.shiftManager,
    );
    _shiftAddViewModel.initial();
    super.initState();
  }

  @override
  void dispose() {
    _shiftAddViewModel.close();
    super.dispose();
  }
}
