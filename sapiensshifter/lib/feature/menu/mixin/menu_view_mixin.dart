import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/menu/view/menu_view.dart';
import 'package:sapiensshifter/feature/menu/view_model/menu_view_model.dart';
import 'package:sapiensshifter/feature/menu/view_model/state/menu_view_state.dart';

mixin MenuViewMixin on BaseState<MenuView> {
  late final MenuViewModel _menuViewModel;

  MenuViewModel get viewModel => _menuViewModel;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _menuViewModel = MenuViewModel(
      MenuViewState.initial(table: widget.table),
      currentUser: widget.currentUser,
      networkManager: ProductConfigureItems.networkManager,
    );
    _menuViewModel.getCategories();
    super.initState();
  }
}
