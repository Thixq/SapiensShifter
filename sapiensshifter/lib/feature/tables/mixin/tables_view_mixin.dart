import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/tables/view/tables_view.dart';
import 'package:sapiensshifter/feature/tables/view_model/tables_view_model.dart';

mixin TablesViewMixin on BaseState<TablesView> {
  late final TablesViewModel _tablesViewModel;

  TablesViewModel get viewModel => _tablesViewModel;

  @override
  void initState() {
    _tablesViewModel =
        TablesViewModel(networkManager: FirebaseFirestoreManager.instance);

    super.initState();
  }
}
