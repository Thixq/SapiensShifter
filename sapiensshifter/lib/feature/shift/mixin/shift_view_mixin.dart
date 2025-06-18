import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/routing/model/route_aware_action_performer.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift/view/shift_view.dart';
import 'package:sapiensshifter/feature/shift/view_model/shift_view_model.dart';
import 'package:sapiensshifter/feature/shift/view_model/state/shift_view_state.dart';
import 'package:sapiensshifter/product/utils/mixin/func/month_full_weeks.dart';

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
    firstWeekFirstDay =
        MonthFullWeeksMixin().getCurrentMonthFullWeeksRange().start;
    _shiftViewModel = ShiftViewModel(
      ShiftViewState.initial(),
      networkManager: ProductConfigureItems.networkManager,
      profile: profile,
    );
    _shiftViewModel.initial(firstWeekFirstDay: firstWeekFirstDay);
    super.initState();
  }
}
