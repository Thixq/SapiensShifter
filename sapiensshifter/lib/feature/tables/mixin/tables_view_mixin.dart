part of '../view/tables_view.dart';

mixin TablesViewMixin on BaseState<TablesView>
    implements RouteAwareActionPerformer {
  late final TablesViewModel _tablesViewModel;

  TablesViewModel get viewModel => _tablesViewModel;
  late final Profile profile;

  @override
  void initState() {
    profile = ProductConfigureItems.profile;
    _tablesViewModel = TablesViewModel(
      TablesViewState.initial(branchName: ''),
      networkManager: ProductConfigureItems.networkManager,
      profile: profile,
    );
    initial(profile);
    super.initState();
  }

  @override
  void onRoutePoppedNext() {
    _tablesViewModel.fetchTables();
  }

  void newOrder(BuildContext context, TableModel? table) {
    context.router.push<TableModel>(
      MenuRoute(
        table: table!,
      ),
    );
  }

  Future<void> initial(Profile profile) async {
    await ProductConfigureItems.shiftManager.reload();

    await profile.setWorkingStatus(
      shiftDay: ProductConfigureItems.shiftManager.toDayBranch,
    );
    await _tablesViewModel.initial();
  }

  @override
  void dispose() {
    _tablesViewModel.close();
    super.dispose();
  }
}
