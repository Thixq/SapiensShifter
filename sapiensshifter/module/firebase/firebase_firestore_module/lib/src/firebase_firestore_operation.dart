// FirebaseFirestoreOperation Class handles Firestore operations with a type-safe approach.
// It is designed to work with models that implement `BaseModelInterface` and utilizes the Firestore SDK for database operations.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import 'exception/module_firestore_exception.dart';

part 'utils/mixin/firestore_helper_mixin.dart';

// The FirebaseFirestoreOperation class is a generic class that works with models extending BaseModelInterface.
// It performs asynchronous Firestore operations like adding, updating, fetching, and deleting documents.
final class FirebaseFirestoreOperation<T extends BaseModelInterface<T>>
    extends NetworkStoreOperationInterface<T> with FirestoreHelperMixin {
  // Constructor initializes the Firestore instance, which is used for performing Firestore operations.
  FirebaseFirestoreOperation({required FirebaseFirestore firestore})
      : _firestore = firestore;

  late final FirebaseFirestore
      _firestore; // Firestore instance to interact with the database.

  // `addItem` adds a single item to Firestore. If a document ID exists, it updates that document, otherwise, it adds a new one.
  @override
  Future<bool> addItem({
    required String path, // Path to the collection and document in Firestore.
    required T
        item, // The item to be added, which is a model implementing `BaseModelInterface<T>`.
  }) {
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        // If no document ID is provided, we are adding a new document.
        if (docId == null) {
          // Add the new item to the collection. Converts the item to JSON before storing.
          await _firestore.collection(collectionPath).add(item.toJson());
        } else {
          // If document ID exists, update the existing document with the new data.
          await _firestore
              .collection(collectionPath)
              .doc(docId)
              .set(item.toJson(), SetOptions(merge: true));
        }
        return true; // Return true indicating the operation was successful.
      },
    );
  }

  // `addAllItem` adds multiple items in batches. It cannot operate on specific documents, only entire collections.
  @override
  Future<bool> addAllItem({
    required String path, // Path to the Firestore collection.
    required List<T> items, // List of items to add.
  }) {
    final (collectionPath, docId) = _getCollectionAndDocId(path);

    // If a document ID is provided, an error is thrown because batch operations require working with collections.
    if (docId != null) {
      throw ModuleFirestoreException('invalid_path_exception');
    }

    return handleAsyncOperation<bool, FirebaseException>(() async {
      // Process items in batches, each batch can contain up to 500 operations.
      await _processBatchedOperations<T, Map<String, dynamic>>(
        items: items,
        batchLimit: 500, // Maximum number of operations per batch.
        createBatch: () =>
            _firestore.batch(), // Create a new batch for Firestore operations.
        batchOperation: (batch, item) {
          // For each item, create a new document in the collection.
          batch.set(
            _firestore.collection(collectionPath).doc(),
            item.toJson(),
          );
        },
        errorMapper: (item) =>
            item.toJson(), // Convert each item to a map for error handling.
      );
      return true; // Return true indicating the batch operation was successful.
    });
  }

  // `deleteItem` removes a document or a field in a document from Firestore.
  @override
  Future<bool> deleteItem({required String path, String? key}) {
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        // If a document ID exists, proceed with deletion of a specific document or field.
        if (docId != null) {
          if (key != null) {
            // If a key is provided, delete that specific field in the document.
            await _firestore.collection(collectionPath).doc(docId).update({
              key: FieldValue.delete(),
            });
          } else {
            // If no key is provided, delete the entire document.
            await _firestore.collection(collectionPath).doc(docId).delete();
          }
        } else {
          // If no document ID, delete all documents in the collection.
          await _deleteCollection(_firestore.collection(collectionPath));
        }
        return true; // Return true to indicate successful deletion.
      },
    );
  }

  // `getItem` retrieves a single item from Firestore based on the path.
  @override
  Future<T> getItem({required String path, String? key}) async {
    return handleAsyncOperation<T, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        // If no document ID is provided, throw an exception since a valid document ID is required.
        if (docId == null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }

        // Prepare the document reference with a custom converter to map Firestore data to the model.
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

        // Fetch the document from Firestore.
        final docSnapshot = await docRef.get();

        // If the document doesn't exist, throw an exception.
        if (!docSnapshot.exists) {
          throw ModuleFirestoreException('document_not_found_exception',
              optionArgs: {'path': path});
        }

        // Return the data as the model type.
        return docSnapshot.data()!;
      },
    );
  }

  // `getItemsQuery` retrieves a list of items from Firestore based on a query.
  @override
  Future<List<T>> getItemsQuery({
    required String path, // Path to the Firestore collection.
    String? key, // Optional key, used to identify the document.
    NetworkStoreQueryInterface? query, // Optional query for filtering the data.
  }) async {
    return handleAsyncOperation<List<T>, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        // If a document ID is provided, it throws an exception since we are querying collections.
        if (docId != null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }

        // Get the reference to the collection.
        var collectionRef = _firestore.collection(collectionPath);

        // If a query is provided, apply it to the Firestore collection reference.
        if (query != null) {
          collectionRef =
              query.applyToQuery<CollectionReference<Map<String, dynamic>>>(
                  collectionRef.path);
        }

        // Fetch the query snapshot, which contains the documents in the collection.
        final querySnapshot = await collectionRef.get();

        // Map each document to the model type and return the list of items.
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

  // `replaceItem` replaces an existing item in Firestore based on the provided path and key.
  @override
  Future<bool> replaceItem({
    required String path, // Path to the document.
    required T item, // The item to replace the existing document with.
    String? key, // Optional key to identify the document to be replaced.
  }) async {
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        // If no document ID or key is provided, throw an exception as the operation is invalid.
        if (docId == null || key == null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }

        final docRef = _firestore.collection(collectionPath).doc(key);

        // Replace the existing document with the new item. It will not merge the existing fields but overwrite them entirely.
        await docRef.set(
          item.toJson(),
          SetOptions(
            merge: false, // Set merge to false to ensure a full overwrite.
          ),
        );

        return true; // Return true indicating the replacement was successful.
      },
    );
  }

  // `update` updates an existing document with the specified values in Firestore.
  @override
  Future<bool> update({
    required String path, // Path to the Firestore document.
    required Map<String, dynamic> value, // Map containing the fields to update.
  }) async {
    return handleAsyncOperation<bool, FirebaseException>(
      () async {
        final (collectionPath, docId) = _getCollectionAndDocId(path);

        // If no document ID is provided, throw an exception.
        if (docId == null) {
          throw ModuleFirestoreException('invalid_path_exception');
        }

        // Perform the update operation in Firestore.
        await _firestore.collection(collectionPath).doc(docId).update(value);
        return true; // Return true indicating the update was successful.
      },
    );
  }

  Stream<dynamic> getStream({
    required String path,
    NetworkStoreQueryInterface? query,
  }) {
    final (collectionPath, docId) = _getCollectionAndDocId(path);

    if (docId != null) {
      if (query != null) {
        throw ModuleFirestoreException('invalid_query_exception');
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
      return docRef.snapshots().map((snapshot) {
        if (!snapshot.exists) {
          throw ModuleFirestoreException('document_not_found_exception',
              optionArgs: {'path': path});
        }
        return snapshot.data()!;
      });
    } else {
      CollectionReference<Map<String, dynamic>> collectionRef =
          _firestore.collection(collectionPath);
      if (query != null) {
        collectionRef =
            query.applyToQuery<CollectionReference<Map<String, dynamic>>>(
                collectionRef.path);
      }
      return collectionRef.snapshots().map((querySnapshot) => querySnapshot.docs
          .map((doc) => (T as BaseModelInterface<T>).fromJson(doc.data()))
          .toList());
    }
  }

  // Helper method to delete all documents in a Firestore collection.
  Future<void> _deleteCollection(CollectionReference collection) async {
    const batchLimit = 500; // Limit the number of operations per batch to 500.

    // Fetch all documents from the collection.
    final querySnapshot = await collection.get();
    final docs = querySnapshot.docs;

    // Process the documents in batches and delete them.
    await _processBatchedOperations<DocumentSnapshot, String>(
      items: docs,
      batchLimit: batchLimit, // Maximum batch size.
      createBatch: () => _firestore.batch(), // Create a new Firestore batch.
      batchOperation: (batch, doc) {
        batch.delete(doc
            .reference); // Add delete operation to the batch for each document.
      },
      errorMapper: (doc) =>
          doc.id, // Map error to document ID for better tracking.
    );
  }
}
