import 'package:core/src/interfaces/network_query_interface/network_query_utils/cursor_condition.dart';

import 'network_query_utils/filter_condition.dart';
import 'network_query_utils/order_by_condition.dart';

abstract class INetworkQuery {
  INetworkQuery({
    this.limit,
    this.limitToLast,
    this.cursors,
    this.orderBy,
    this.filters,
  });

  final int? limit;

  final int? limitToLast;

  final List<CursorCondition>? cursors;

  final List<OrderByCondition>? orderBy;

  final List<FilterCondition>? filters;

  T applyToQuery<T>(String path);
}
