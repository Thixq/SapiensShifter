// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

final class TablesViewState {
  TablesViewState({
    required this.tableList,
    required this.isLoading,
    required this.isWorking,
    this.notWorkingMessage,
    this.branchName,
  });

  factory TablesViewState.initial({
    String? branchName,
    String? notWorkingMessage,
  }) {
    return TablesViewState(
      isWorking: false,
      tableList: [],
      isLoading: true,
      branchName: branchName,
      notWorkingMessage: notWorkingMessage,
    );
  }
  final bool isWorking;

  final List<TableModel> tableList;
  final bool isLoading;
  final String? notWorkingMessage;
  final String? branchName;

  TablesViewState copyWith({
    bool? isWorking,
    List<TableModel>? tableList,
    bool? isLoading,
    String? notWorkingMessage,
    String? branchName,
  }) {
    return TablesViewState(
      isWorking: isWorking ?? this.isWorking,
      tableList: tableList ?? this.tableList,
      isLoading: isLoading ?? this.isLoading,
      notWorkingMessage: notWorkingMessage ?? this.notWorkingMessage,
      branchName: branchName ?? this.branchName,
    );
  }
}
