// lib/src/data/firestore/firestore_transaction.dart

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:core/core.dart';
import 'package:firebase_firestore_module/src/exception/module_firestore_exception.dart';

/// ITransaction arayüzünün Firestore'a özel implementasyonu.
/// Dahili olarak bir Firestore `Transaction` nesnesini yönetir.
class FirestoreTransaction implements ITransaction {
  final fs.Transaction _firestoreTransaction;
  final fs.FirebaseFirestore _firestoreInstance;

  FirestoreTransaction(this._firestoreTransaction, this._firestoreInstance);

  @override
  Future<T> get<T extends IBaseModel<T>>({
    required String path,
    required T model,
  }) async {
    final docRef = _firestoreInstance.doc(path);
    final snapshot = await _firestoreTransaction.get(docRef);

    if (!snapshot.exists || snapshot.data() == null) {
      throw ModuleFirestoreException('document_not_found_exception',
          optionArgs: {'path': path});
    }
    return model.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  void set<T extends IBaseModel<T>>({required String path, required T item}) {
    final docRef = _firestoreInstance.doc(path);
    _firestoreTransaction.set(docRef, item.toJson());
  }

  @override
  void update({required String path, required Map<String, dynamic> data}) {
    final docRef = _firestoreInstance.doc(path);
    _firestoreTransaction.update(docRef, data);
  }

  @override
  void delete({required String path}) {
    final docRef = _firestoreInstance.doc(path);
    _firestoreTransaction.delete(docRef);
  }
}
