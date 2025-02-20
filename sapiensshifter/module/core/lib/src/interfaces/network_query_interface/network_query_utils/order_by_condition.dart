class OrderByCondition {
  OrderByCondition({
    required this.field,
    this.descending = false,
  });
  final String field;
  final bool descending;
}
