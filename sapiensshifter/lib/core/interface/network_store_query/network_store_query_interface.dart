abstract class NetworkStoreQueryInterface {
  NetworkStoreQueryInterface({
    this.limit,
    this.limitToLast,
    this.orderBy,
    this.filters,
  });
  final int? limit;
  final int? limitToLast;
  final List<OrderByCondition>? orderBy;
  final List<FilterCondition>? filters;
  T applyToCollection<T>(String path);
}

enum FilterOperator {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
  isNull
}

// TODO(kaan): parçala.
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

class OrderByCondition {
  OrderByCondition({
    required this.field,
    this.descending = false,
  });
  final String field;
  final bool descending;
}
