part of '../../firebase_firestore_operation.dart';

typedef BatchOperation<T> = void Function(WriteBatch batch, T item);
typedef ErrorMapper<T, E> = E Function(T item);

mixin class FirestoreHelperMixin {
  Future<void> _processBatchedOperations<T, E>({
    required List<T> items,
    required int batchLimit,
    required WriteBatch Function() createBatch,
    required BatchOperation<T> batchOperation,
    required ErrorMapper<T, E> errorMapper,
  }) async {
    final batches = <Future<void>>[];
    final failedItems = <T>[];

    for (var i = 0; i < items.length; i += batchLimit) {
      final sublist = items.sublist(
        i,
        (i + batchLimit) > items.length ? items.length : (i + batchLimit),
      );

      final batch = createBatch();
      for (final item in sublist) {
        batchOperation(batch, item);
      }

      batches.add(
        batch.commit().catchError((error) {
          failedItems.addAll(sublist);
        }),
      );
    }

    await Future.wait(batches);

    if (failedItems.isNotEmpty) {
      throw ModuleFirestoreException('batch_commit_exception',
          optionArgs: {'failedDocs': failedItems.map(errorMapper).toList()});
    }
  }

  (String, String?) _getCollectionAndDocId(String path) {
    final pathSegments = path.split('/');

    if (pathSegments.length.isOdd) {
      return (path, null);
    } else {
      final docId = pathSegments.removeLast();
      final collectionPath = pathSegments.join('/');
      return (collectionPath, docId);
    }
  }
}
