import 'package:sapiensshifter/product/models/table_model.dart';

final class TablesViewState {
  TablesViewState({
    required this.tableList,
    required this.isLoading,
  });

  factory TablesViewState.initial() {
    return TablesViewState(
      tableList: [],
      isLoading: true,
    );
  }
  final List<TableModel> tableList;
  final bool isLoading;

  TablesViewState copyWith({
    List<TableModel>? tableList,
    bool? isLoading,
  }) {
    return TablesViewState(
      tableList: tableList ?? this.tableList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
