import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

final class FirebaseFirestoreCustomQuery extends INetworkQuery {
  FirebaseFirestoreCustomQuery({
    super.limit,
    super.limitToLast,
    super.cursors,
    super.orderBy,
    super.filters,
  });

  @override
  T applyToQuery<T>(String path) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);

    // Apply filters to the query if any exist.
    filters?.forEach((filter) {
      final field = filter.field;
      final value = filter.value;
      final operator = filter.operator;

      // Map of supported Firestore filter operations.
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
        FilterOperator.isEqualToDateTime: () {
          if (value is DateTime) {
            final timeStamp = Timestamp.fromDate(value);
            query = query.where(field, isEqualTo: timeStamp);
          }
        },
        FilterOperator.isGreaterThanOrEqualToDateTime: () {
          if (value is DateTime) {
            final timeStamp = Timestamp.fromDate(value);
            query = query.where(field, isGreaterThanOrEqualTo: timeStamp);
          }
        },
        FilterOperator.isNull: () => query = query.where(field, isNull: true),
      };

      // Apply the corresponding filter operation.
      operationMap[operator]?.call();
    });

    cursors?.forEach(
      (cursor) {
        final cursorType = cursor.type;
        switch (cursorType) {
          case CursorType.startAt:
            query = query.startAt(cursor.fieldValues);
          case CursorType.startAfter:
            query = query.startAfter(cursor.fieldValues);
          case CursorType.endAt:
            query = query.endAt(cursor.fieldValues);
          case CursorType.endBefore:
            query = query.endBefore(cursor.fieldValues);
        }
      },
    );

    // Apply ordering to the query if specified.
    orderBy?.forEach((order) {
      query = query.orderBy(order.field, descending: order.descending);
    });

    // Apply limits to the query.
    if (limitToLast != null) {
      query = query.limitToLast(limitToLast!);
    } else if (limit != null) {
      query = query.limit(limit!);
    }

    return query as T;
  }
}
