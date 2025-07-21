part of '../view/menu_view.dart';

mixin MenuViewMixin on BaseState<MenuView> {
  late final MenuViewModel _menuViewModel;
  final Profile _profile = ProductConfigureItems.profile;

  MenuViewModel get viewModel => _menuViewModel;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _menuViewModel = MenuViewModel(
      MenuViewState.initial(table: widget.table),
      profile: _profile,
      networkManager: ProductConfigureItems.networkManager,
    );
    _menuViewModel.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _menuViewModel.close();
    super.dispose();
  }
}
