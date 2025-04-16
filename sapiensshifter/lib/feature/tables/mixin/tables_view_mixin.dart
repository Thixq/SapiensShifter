import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/tables/view/tables_view.dart';
import 'package:sapiensshifter/feature/tables/view_model/tables_view_model.dart';

mixin TablesViewMixin on BaseState<TablesView> {
  late final TablesViewModel _tablesViewModel;

  TablesViewModel get viewModel => _tablesViewModel;

  @override
  void initState() {
    _tablesViewModel = TablesViewModel(
      networkManager: ProductConfigureItems.networkManager,
      profile: ProductConfigureItems.profile,
    );

    super.initState();
  }
}
