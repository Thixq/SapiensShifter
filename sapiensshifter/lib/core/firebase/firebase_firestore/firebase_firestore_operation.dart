// FirebaseFirestoreOperation Sınıfı

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapiensshifter/core/custom_error_and_exception_hanle/async_error_handler.dart';
import 'package:sapiensshifter/core/exceptions/firebase_exception/firebase_firestore_exception/index.dart';
import 'package:sapiensshifter/core/interface/network_store_query/network_store_query_interface.dart';
import 'package:sapiensshifter/core/interface/operation_interface/network_store_operation_interface.dart';
import 'package:sapiensshifter/product/interface/interface_model/product_base_model_interface.dart';

final class FirebaseFirestoreOperation<T extends ProductBaseModelInterface<T>>
    extends NetworkStoreOperationInterface<T> {
  FirebaseFirestoreOperation({required FirebaseFirestore firestore})
      : _firestore = firestore;

  late final FirebaseFirestore _firestore;

  @override
  Future<bool> addItem({
    required String path,
    required T item,
  }) {
    return handleAsyncOperation<bool>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId == null) {
          await _firestore.collection(collectionPath).add(item.toJson());
        } else {
          await _firestore
              .collection(collectionPath)
              .doc(docId)
              .set(item.toJson(), SetOptions(merge: true));
        }
        return true;
      },
    );
  }

  @override
  Future<bool> addAllItem({
    required String path,
    required List<T> items,
  }) {
    final (collectionPath, docId) = _getCollectionAndDocId(path);

    if (docId != null) {
      throw InvalidPathException();
    }

    return handleAsyncOperation<bool>(() async {
      await _processBatchedOperations<T, Map<String, dynamic>>(
        items: items,
        batchLimit: 500,
        createBatch: () => _firestore.batch(),
        batchOperation: (batch, item) {
          batch.set(
            _firestore.collection(collectionPath).doc(),
            item.toJson(),
          );
        },
        errorMapper: (item) => item.toJson(),
      );
      return true;
    });
  }

  @override
  Future<bool> deleteItem({required String path, String? key}) {
    return handleAsyncOperation<bool>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        if (docId != null) {
          if (key != null) {
            await _firestore.collection(collectionPath).doc(docId).update({
              key: FieldValue.delete(),
            });
          } else {
            await _firestore.collection(collectionPath).doc(docId).delete();
          }
        } else {
          await _deleteCollection(_firestore.collection(collectionPath));
        }
        return true;
      },
    );
  }

  @override
  Future<T> getItem({required String path, String? key}) async {
    return handleAsyncOperation<T>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId == null) {
          throw InvalidPathException();
        }

        final docRef =
            _firestore.collection(collectionPath).doc(docId).withConverter<T>(
                  fromFirestore: (snapshot, _) {
                    final data = snapshot.data();
                    if (data == null) {
                      throw DocumentDataException(path: path);
                    }
                    return (T as ProductBaseModelInterface<T>).fromJson(data);
                  },
                  toFirestore: (model, _) => model.toJson(),
                );

        final docSnapshot = await docRef.get();

        if (!docSnapshot.exists) {
          throw DocumentNotFoundException(path: path);
        }

        return docSnapshot.data()!;
      },
    );
  }

  @override
  Future<List<T>> getItemsQuery({
    required String path,
    String? key,
    NetworkStoreQueryInterface? query,
  }) async {
    return handleAsyncOperation<List<T>>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId != null) {
          throw InvalidPathException();
        }
        var collectionRef = _firestore.collection(collectionPath);
        if (query != null) {
          collectionRef = query.applyToCollection(collectionRef.path);
        }
        final querySnapshot = await collectionRef.get();
        final items = querySnapshot.docs
            .map(
              (doc) => (T as ProductBaseModelInterface<T>).fromJson(doc.data()),
            )
            .cast<T>()
            .toList();

        return items;
      },
    );
  }

  @override
  Future<bool> replaceItem({
    required String path,
    required T item,
    String? key,
  }) async {
    return handleAsyncOperation<bool>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        if (docId == null || key == null) {
          throw InvalidPathException();
        }

        final docRef = _firestore.collection(collectionPath).doc(key);

        await docRef.set(
          item.toJson(),
          SetOptions(
            merge: false,
          ),
        );

        return true;
      },
    );
  }

  @override
  Future<bool> update({
    required String path,
    required Map<String, dynamic> value,
  }) async {
    return handleAsyncOperation<bool>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId == null) {
          throw InvalidPathException();
        }

        await _firestore.collection(collectionPath).doc(docId).update(value);
        return true;
      },
    );
  }

  // TODO(kaan): Firebase Firestore utils mixin oluştur.

  Future<void> _deleteCollection(CollectionReference collection) async {
    const batchLimit = 500;
    final querySnapshot = await collection.get();
    final docs = querySnapshot.docs;

    await _processBatchedOperations<DocumentSnapshot, String>(
      items: docs,
      batchLimit: batchLimit,
      createBatch: () => _firestore.batch(),
      batchOperation: (batch, doc) {
        batch.delete(doc.reference);
      },
      errorMapper: (doc) => doc.id,
    );
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

typedef BatchOperation<T> = void Function(WriteBatch batch, T item);
typedef ErrorMapper<T, E> = E Function(T item);

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
    throw BatchCommitException(
      docs: failedItems.map(errorMapper).toList(),
    );
  }
}
