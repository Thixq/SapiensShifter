// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sapiensshifter/product/models/table_model/table_model.dart';

final class OrderHistoryState {
  OrderHistoryState({required this.isLoading, required this.tables});

  factory OrderHistoryState.inital() {
    return OrderHistoryState(tables: [], isLoading: false);
  }
  final List<TableModel> tables;
  final bool isLoading;

  OrderHistoryState copyWith({
    List<TableModel>? tables,
    bool? isLoading,
  }) {
    return OrderHistoryState(
      tables: tables ?? this.tables,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
