import 'network_store_query_utils/filter_condition.dart';
import 'network_store_query_utils/order_by_condition.dart';

/// An abstract interface for constructing and applying network store queries.
/// This interface allows you to define various query parameters such as limits,
/// ordering, and filtering that can be applied to a collection in a network store.
abstract class NetworkStoreQueryInterface {
  /// Creates an instance of [NetworkStoreQueryInterface].
  ///
  /// Parameters:
  /// - [limit]: Optional. The maximum number of items to retrieve from the collection.
  /// - [limitToLast]: Optional. The maximum number of items to retrieve from the end of the collection.
  /// - [orderBy]: Optional. A list of conditions that specify the ordering of the query results.
  /// - [filters]: Optional. A list of conditions to filter the query results.
  NetworkStoreQueryInterface({
    this.limit,
    this.limitToLast,
    this.orderBy,
    this.filters,
  });

  /// The maximum number of items to retrieve from the beginning of the collection.
  final int? limit;

  /// The maximum number of items to retrieve from the end of the collection.
  final int? limitToLast;

  /// A list of [OrderByCondition] objects that determine the ordering of the query results.
  final List<OrderByCondition>? orderBy;

  /// A list of [FilterCondition] objects that specify the filtering criteria for the query.
  final List<FilterCondition>? filters;

  /// Applies the defined query parameters to a collection identified by [path].
  ///
  /// The [path] parameter specifies the location or identifier of the collection to query.
  ///
  /// Returns:
  /// A result of generic type [T] that represents the outcome of applying the query.
  T applyToCollection<T>(String path);
}
