// FirebaseFirestoreOperation Sınıfı
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import 'exception/module_firestore_exception.dart';

part 'utils/mixin/firestore_helper_mixin.dart';

final class FirebaseFirestoreOperation<T extends BaseModelInterface<T>>
    extends NetworkStoreOperationInterface<T> with FirestoreHelperMixin {
  FirebaseFirestoreOperation({required FirebaseFirestore firestore})
      : _firestore = firestore;

  late final FirebaseFirestore _firestore;

  @override
  Future<bool> addItem({
    required String path,
    required T item,
  }) {
    return handleAsyncOperation<bool, FirebaseException>(
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
      throw ModuleFirestoreException('invalid_path_exception');
    }

    return handleAsyncOperation<bool, FirebaseException>(() async {
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
    return handleAsyncOperation<bool, FirebaseException>(
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
    return handleAsyncOperation<T, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId == null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }

        final docRef =
            _firestore.collection(collectionPath).doc(docId).withConverter<T>(
                  fromFirestore: (snapshot, _) {
                    final data = snapshot.data();
                    if (data == null) {
                      throw ModuleFirestoreException('document_data_exception',
                          optionArgs: {'path': path});
                    }
                    return (T as BaseModelInterface<T>).fromJson(data);
                  },
                  toFirestore: (model, _) => model.toJson(),
                );

        final docSnapshot = await docRef.get();

        if (!docSnapshot.exists) {
          throw ModuleFirestoreException('document_not_found_exception',
              optionArgs: {'path': path});
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
    return handleAsyncOperation<List<T>, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId != null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }
        var collectionRef = _firestore.collection(collectionPath);
        if (query != null) {
          collectionRef =
              query.applyToQuery<CollectionReference<Map<String, dynamic>>>(
                  collectionRef.path);
        }
        final querySnapshot = await collectionRef.get();
        final items = querySnapshot.docs
            .map(
              (doc) => (T as BaseModelInterface<T>).fromJson(doc.data()),
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
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        if (docId == null || key == null) {
          throw ModuleFirestoreException('invalid_path_exception');
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
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);
        if (docId == null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }

        await _firestore.collection(collectionPath).doc(docId).update(value);
        return true;
      },
    );
  }

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
}
