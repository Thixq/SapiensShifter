// FirebaseFirestoreOperation Class handles Firestore operations with a type-safe approach.
// It is designed to work with models that implement `BaseModelInterface` and utilizes the Firestore SDK for database operations.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import 'exception/module_firestore_exception.dart';

part 'utils/mixin/firestore_helper_mixin.dart';

final class FirebaseFirestoreOperation extends INetworkOperation
    with FirestoreHelperMixin {
  FirebaseFirestoreOperation({required FirebaseFirestore firestore})
      : _firestore = firestore;

  late final FirebaseFirestore
      _firestore; // Firestore instance to interact with the database.

  @override
  Future<bool> addItem<T extends IBaseModel<T>>({
    required String path, // Path to the collection and document in Firestore.
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
  Future<bool> addAllItem<T extends IBaseModel<T>>({
    required String path,
    required List<T> items,
  }) {
    final (collectionPath, docId) = _getCollectionAndDocId(path);

    if (docId != null) {
      throw ModuleFirestoreException('invalid_path_exception', optionArgs: {
        'path': path,
      });
    }
    return handleAsyncOperation<bool, FirebaseException>(() async {
      await _processBatchedOperations<T, Map<String, dynamic>>(
        items: items,
        batchLimit: 500,
        createBatch: () => _firestore.batch(),
        batchOperation: (batch, item) {
          batch.set(
            _firestore.collection(collectionPath).doc(item.id),
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
  Future<T> getItem<T extends IBaseModel<T>>(
      {required String path, required T model, String? key}) async {
    return handleAsyncOperation<T, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        if (docId == null) {
          throw ModuleFirestoreException('invalid_path_exception',
              optionArgs: {'path': path});
        }

        final docRef =
            _firestore.collection(collectionPath).doc(docId).withConverter<T>(
                  fromFirestore: (snapshot, _) {
                    final data = snapshot.data();
                    if (data == null) {
                      throw ModuleFirestoreException('document_data_exception',
                          optionArgs: {'path': path});
                    }
                    return model.fromJson(data);
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
  Future<List<T>> getItemsQuery<T extends IBaseModel<T>>({
    required String path,
    required T model,
    String? key,
    INetworkQuery? query,
  }) async {
    return handleAsyncOperation<List<T>, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        if (docId != null) {
          throw ModuleFirestoreException('invalid_path_exception',
              optionArgs: {'path': path});
        }

        var collectionRef = _firestore.collection(collectionPath);
        Query<Map<String, dynamic>> queryCollectionRef = collectionRef;

        if (query != null) {
          queryCollectionRef = query
              .applyToQuery<Query<Map<String, dynamic>>>(collectionRef.path);
        }

        final querySnapshot = await queryCollectionRef.get();

        final items = querySnapshot.docs
            .map(
              (doc) {
                return model.fromJson(doc.data());
              },
            )
            .cast<T>()
            .toList();

        return items;
      },
    );
  }

  @override
  Future<bool> replaceItem<T extends IBaseModel<T>>({
    required String path,
    required T item,
    String? key,
  }) async {
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        if (docId == null || key == null) {
          throw ModuleFirestoreException('invalid_path_exception',
              optionArgs: {'path': path});
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
          throw ModuleFirestoreException('invalid_path_exception',
              optionArgs: {'path': path});
        }
        final transValue = _translateToFirestore(value);
        await _firestore
            .collection(collectionPath)
            .doc(docId)
            .update(transValue);

        return true;
      },
    );
  }

  @override
  Future<bool> updateAll<T extends IBaseModel<T>>({
    required String path,
    required List<T> items,
  }) async {
    final (collectionPath, docId) = _getCollectionAndDocId(path);

    if (docId != null) {
      throw ModuleFirestoreException('invalid_path_exception', optionArgs: {
        'path': path,
      });
    }
    return handleAsyncOperation<bool, FirebaseException>(() async {
      await _processBatchedOperations(
        items: items,
        batchLimit: 500,
        createBatch: () => _firestore.batch(),
        batchOperation: (batch, item) {
          batch.update(
            _firestore.collection(collectionPath).doc(item.id),
            item.toJson(),
          );
        },
        errorMapper: (item) => item.id,
      );
      return true;
    });
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

  @override
  Stream<T> getStream<T extends IBaseModel<T>>(
      {required String path, required T model, String? key}) {
    return _firestore.doc(path).snapshots().map((docSnapshot) {
      final data = docSnapshot.data();
      if (data != null) {
        return model.fromJson(data);
      } else {
        throw ModuleFirestoreException('invalid_path_exception',
            optionArgs: {'path': path});
      }
    });
  }

  @override
  Stream<List<T>> getStreamQuery<T extends IBaseModel<T>>(
      {required String path,
      required T model,
      String? key,
      INetworkQuery? query}) {
    var collectionRef = _firestore.collection(path);
    Query<Map<String, dynamic>> queryCollectionRef = collectionRef;

    if (query != null) {
      queryCollectionRef =
          query.applyToQuery<Query<Map<String, dynamic>>>(collectionRef.path);
    }
    return queryCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) {
            final data = docSnapshot.data();
            return model.fromJson(data);
          })
          .cast<T>()
          .toList();
    }).cast<List<T>>();
  }
}
