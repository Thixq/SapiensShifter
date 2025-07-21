part of '../view/shift_add_view.dart';

mixin ShiftAddMixin on BaseState<ShiftAddView> {
  late final ShiftAddViewModel _shiftAddViewModel;
  ShiftAddViewModel get viewModel => _shiftAddViewModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onConfrim(String? peopleId) {
    if (formKey.currentState?.validate() ?? false) {
      viewModel.shiftAdd(peopleId: peopleId);
      showSnakeToastMessage(
        context,
        message: LocaleKeys.page_sihft_add_view_show_toast_message.tr(),
      );
    }
  }

  @override
  void initState() {
    _shiftAddViewModel = ShiftAddViewModel(
      ShiftAddState.initial(
        shiftMap: {
          for (final item in List.generate(7, (index) => index))
            item: const ShiftDay(),
        },
      ),
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
