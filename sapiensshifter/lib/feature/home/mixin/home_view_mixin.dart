part of '../view/home_view.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  final profile = ProductConfigureItems.profile;

  @override
  void initState() {
    requestNotification();
    super.initState();
  }

  List<PageItem> get pages => <PageItem>[
        PageItem(
          page: const ChatPreviewRoute(),
          navBarItem: NavBarItem(
            icon: Icons.message,
          ),
        ),
        PageItem(
          page: const TablesRoute(),
          navBarItem: NavBarItem(
            icon: Icons.table_bar,
            onPress: () {
              profile.sessionState.workingStatus.map(
                onWorking: (working) async => SapiCounterDialog.show(
                  context,
                  titleName: LocaleKeys.page_home_new_table.tr(),
                  done: (title, count) => _newTable(
                    title,
                    count,
                    working.branchId,
                  ),
                ),
                onOffDay: (offDay) => null,
                onUnassigned: (unassigned) => null,
              );
            },
          ),
        ),
        PageItem(
          page: const ShiftRoute(),
          navBarItem: NavBarItem(icon: Icons.ssid_chart),
        ),
      ];

  void _newTable(String? tableName, int? peopleCount, String? branchId) {
    final newTableModel = TableModel(
      peopleCount: peopleCount,
      tableName: tableName,
      branchId: branchId,
      creatorId: profile.user?.id,
      timeStamp: DateTime.now(),
      status: true,
      id: const UuidV7().generate(),
    );
    context.router.push<TableModel>(
      MenuRoute(
        table: newTableModel,
      ),
    );
  }

  List<NavBarItem> get navBarItems {
    return pages
        .map(
          (e) => e.navBarItem,
        )
        .toList();
  }

  Future<void> requestNotification() async {
    final result = await NotificationService.instance.requestPermissions();
    if (result != null && result) {
      await NotificationTokenManager.instance.deviceSync();
      await NotificationService.instance.initialize();
    }
  }
}
