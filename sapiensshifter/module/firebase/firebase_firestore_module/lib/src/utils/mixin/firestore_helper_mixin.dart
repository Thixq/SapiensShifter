part of '../../firebase_firestore_operation.dart';

/// Defines a function type for performing batched operations on Firestore documents.
typedef BatchOperation<T> = void Function(WriteBatch batch, T item);

/// Defines a function type for mapping an item to an error format.
typedef ErrorMapper<T, E> = E Function(T item);

/// A mixin that provides helper functions for Firestore batch operations.
mixin class FirestoreHelperMixin {
  /// Processes a list of Firestore operations in batches to avoid exceeding limits.
  ///
  /// - [items]: The list of items to process in Firestore.
  /// - [batchLimit]: The maximum number of items per batch.
  /// - [createBatch]: Function to create a new Firestore batch.
  /// - [batchOperation]: Function that applies operations on a batch for each item.
  /// - [errorMapper]: Function that maps failed items to error formats.
  Future<void> _processBatchedOperations<T, E>({
    required List<T> items,
    required int batchLimit,
    required WriteBatch Function() createBatch,
    required BatchOperation<T> batchOperation,
    required ErrorMapper<T, E> errorMapper,
  }) async {
    final batches = <Future<void>>[]; // Stores batch commit operations.
    final failedItems = <T>[]; // Tracks failed items.

    // Loop through items in chunks defined by batchLimit.
    for (var i = 0; i < items.length; i += batchLimit) {
      final sublist = items.sublist(
        i,
        (i + batchLimit) > items.length ? items.length : (i + batchLimit),
      );

      final batch = createBatch();

      // Apply batch operations to each item in the sublist.
      for (final item in sublist) {
        batchOperation(batch, item);
      }

      // Commit the batch and track any failures.
      batches.add(
        batch.commit().catchError((error) {
          failedItems.addAll(sublist);
        }),
      );
    }

    await Future.wait(batches); // Wait for all batches to complete.

    // If any items failed, throw a Firestore-specific exception.
    if (failedItems.isNotEmpty) {
      throw ModuleFirestoreException(
        'batch_commit_exception',
        optionArgs: {
          'failedDocs': failedItems.map(errorMapper).toList().toString()
        },
      );
    }
  }

  /// Extracts the collection path and document ID from a Firestore document path.
  ///
  /// - If the path represents a collection (odd number of segments), returns (collectionPath, null).
  /// - If the path represents a document (even number of segments), returns (collectionPath, docId).
  (String, String?) _getCollectionAndDocId(String path) {
    // 1. Baştaki/sondaki '/' temizle, boş segmentleri kaldır
    final cleanedPath = path.replaceAll(RegExp(r'^/+|/+$'), '');
    final pathSegments =
        cleanedPath.split('/').where((s) => s.isNotEmpty).toList();

    // 2. Firestore path kontrolü
    if (pathSegments.isEmpty) {
      return ('', null); // Kök koleksiyon (root)
    } else if (pathSegments.length.isEven) {
      // Çift sayıda segment: Son segment DOCUMENT ID
      final docId = pathSegments.removeLast();
      return (pathSegments.join('/'), docId);
    } else {
      // Tek sayıda segment: COLLECTION path (son segment koleksiyon adı)
      return (pathSegments.join('/'), null);
    }
  }
}
