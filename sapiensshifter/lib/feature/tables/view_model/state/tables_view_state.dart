// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

final class TablesViewState {
  TablesViewState({
    required this.tableList,
    required this.isLoading,
    this.branchName,
  });

  factory TablesViewState.initial({String? branchName}) {
    return TablesViewState(
      tableList: [],
      isLoading: true,
      branchName: branchName,
    );
  }
  final List<TableModel> tableList;
  final bool isLoading;
  final String? branchName;

  TablesViewState copyWith({
    List<TableModel>? tableList,
    bool? isLoading,
    String? branchName,
  }) {
    return TablesViewState(
      tableList: tableList ?? this.tableList,
      isLoading: isLoading ?? this.isLoading,
      branchName: branchName ?? this.branchName,
    );
  }
}
