part 'filter_operator_enum.dart';

class FilterCondition {
  FilterCondition({
    required this.field,
    required this.value,
    this.operator = FilterOperator.isEqualTo,
  });
  final String field;
  final dynamic value;
  final FilterOperator operator;
}
