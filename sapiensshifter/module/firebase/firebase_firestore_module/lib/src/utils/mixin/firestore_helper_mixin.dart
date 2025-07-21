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
      throw ModuleFirestoreException(
        'batch_commit_exception',
        optionArgs: {
          'failedDocs': failedItems.map(errorMapper).toList().toString()
        },
      );
    }
  }

  (String, String?) _getCollectionAndDocId(String path) {
    final cleanedPath = path.replaceAll(RegExp(r'^/+|/+$'), '');
    final pathSegments =
        cleanedPath.split('/').where((s) => s.isNotEmpty).toList();

    if (pathSegments.isEmpty) {
      return ('', null);
    } else if (pathSegments.length.isEven) {
      final docId = pathSegments.removeLast();
      return (pathSegments.join('/'), docId);
    } else {
      return (pathSegments.join('/'), null);
    }
  }

  Map<String, dynamic> _translateToFirestore(Map<String, dynamic> data) {
    final Map<String, dynamic> translatedData = {};

    data.forEach((key, value) {
      if (value is ValueFieldInterface) {
        if (value is IncrementOperation) {
          translatedData[key] = FieldValue.increment(value.value);
        } else if (value is ArrayUnionOperation) {
          translatedData[key] = FieldValue.arrayUnion(value.elements);
        } else if (value is ArrayRemoveOperation) {
          translatedData[key] = FieldValue.arrayRemove(value.elements);
        } else if (value is DeleteFieldOperation) {
          translatedData[key] = FieldValue.delete();
        } else if (value is ServerTimestampOperation) {
          translatedData[key] = FieldValue.serverTimestamp();
        }
      } else {
        if (value is Map<String, dynamic>) {
          translatedData[key] = _translateToFirestore(value);
        } else {
          translatedData[key] = value;
        }
      }
    });

    return translatedData;
  }
}
