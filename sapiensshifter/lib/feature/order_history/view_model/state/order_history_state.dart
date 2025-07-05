// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

final class OrderHistoryState {
  OrderHistoryState({
    required this.isLoading,
    required this.tables,
    required this.isWorking,
    required this.notWorkingMessage,
  });

  factory OrderHistoryState.inital() {
    return OrderHistoryState(
      tables: [],
      isLoading: false,
      isWorking: false,
      notWorkingMessage: '',
    );
  }
  final List<TableModel> tables;
  final bool isLoading;
  final bool isWorking;
  final String notWorkingMessage;

  OrderHistoryState copyWith({
    List<TableModel>? tables,
    bool? isLoading,
    bool? isWorking,
    String? notWorkingMessage,
  }) {
    return OrderHistoryState(
      tables: tables ?? this.tables,
      isLoading: isLoading ?? this.isLoading,
      isWorking: isWorking ?? this.isWorking,
      notWorkingMessage: notWorkingMessage ?? this.notWorkingMessage,
    );
  }
}
