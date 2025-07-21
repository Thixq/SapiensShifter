part of '../view/shift_view.dart';

mixin ShiftViewMixin on BaseState<ShiftView>
    implements RouteAwareActionPerformer {
  final profile = ProductConfigureItems.profile;
  late final ShiftViewModel _shiftViewModel;
  ShiftViewModel get viewModel => _shiftViewModel;
  late final DateTime firstWeekFirstDay;

  @override
  void onRoutePoppedNext() {
    _shiftViewModel.getShift(firstWeekFirstDay: firstWeekFirstDay);
  }

  @override
  void initState() {
    firstWeekFirstDay = MonthFullWeeks.getCurrentMonthFullWeeksRange().start;
    _shiftViewModel = ShiftViewModel(
      ShiftViewState.initial(),
      shiftManager: ProductConfigureItems.shiftManager,
    );
    _shiftViewModel.initial(firstWeekFirstDay: firstWeekFirstDay);
    super.initState();
  }

  @override
  void dispose() {
    _shiftViewModel.close();
    super.dispose();
  }
}
