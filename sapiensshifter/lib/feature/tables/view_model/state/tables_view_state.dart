// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

final class TablesViewState {
  TablesViewState({
    required this.tableList,
    required this.isLoading,
    required this.emptyBracnh,
    this.branchName,
  });

  factory TablesViewState.initial({String? branchName}) {
    return TablesViewState(
      emptyBracnh: true,
      tableList: [],
      isLoading: true,
      branchName: branchName,
    );
  }
  final bool emptyBracnh;
  final List<TableModel> tableList;
  final bool isLoading;
  final String? branchName;

  TablesViewState copyWith({
    bool? emptyBracnh,
    List<TableModel>? tableList,
    bool? isLoading,
    String? branchName,
  }) {
    return TablesViewState(
      emptyBracnh: emptyBracnh ?? this.emptyBracnh,
      tableList: tableList ?? this.tableList,
      isLoading: isLoading ?? this.isLoading,
      branchName: branchName ?? this.branchName,
    );
  }
}
