import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapiensshifter/core/interface/network_store_query/network_store_query_interface.dart';

class FirebaseFirestoreCustomQuery extends NetworkStoreQueryInterface {
  FirebaseFirestoreCustomQuery({
    super.limit,
    super.limitToLast,
    super.orderBy,
    super.filters,
  });

  @override
  T applyToCollection<T>(String path) {
    Query<Object?> query = FirebaseFirestore.instance.collection(path);

    filters?.forEach((filter) {
      final field = filter.field;
      final value = filter.value;
      final operator = filter.operator;

      final operationMap = {
        FilterOperator.isEqualTo: () =>
            query = query.where(field, isEqualTo: value),
        FilterOperator.isNotEqualTo: () =>
            query = query.where(field, isNotEqualTo: value),
        FilterOperator.isLessThan: () =>
            query = query.where(field, isLessThan: value),
        FilterOperator.isLessThanOrEqualTo: () =>
            query = query.where(field, isLessThanOrEqualTo: value),
        FilterOperator.isGreaterThan: () =>
            query = query.where(field, isGreaterThan: value),
        FilterOperator.isGreaterThanOrEqualTo: () =>
            query = query.where(field, isGreaterThanOrEqualTo: value),
        FilterOperator.arrayContains: () =>
            query = query.where(field, arrayContains: value),
        FilterOperator.arrayContainsAny: () => query =
            query.where(field, arrayContainsAny: value as Iterable<Object?>?),
        FilterOperator.whereIn: () =>
            query = query.where(field, whereIn: value as Iterable<Object?>?),
        FilterOperator.whereNotIn: () =>
            query = query.where(field, whereNotIn: value as Iterable<Object?>?),
        FilterOperator.isNull: () => query = query.where(field, isNull: true),
      };

      operationMap[operator]?.call();
    });

    // Sıralama uygula
    orderBy?.forEach((order) {
      query = query.orderBy(order.field, descending: order.descending);
    });

    // Limitleri uygula
    if (limitToLast != null) {
      query = query.limitToLast(limitToLast!);
    } else if (limit != null) {
      query = query.limit(limit!);
    }

    return query as T;
  }
}
