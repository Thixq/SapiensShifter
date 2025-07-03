import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

class FirestoreBatchWriter implements IBatchWriter {
  final WriteBatch _batch;
  final FirebaseFirestore _firestoreInstance;

  FirestoreBatchWriter(this._batch, this._firestoreInstance);

  @override
  void create<T extends IBaseModel<T>>({
    required String path,
    required T item,
  }) {
    final DocumentReference docRef = _firestoreInstance.doc(path);
    _batch.set(docRef, item.toJson(), SetOptions(merge: false));
  }

  @override
  void set<T extends IBaseModel<T>>({
    required String path,
    required T item,
  }) {
    final DocumentReference docRef = _firestoreInstance.doc(path);
    _batch.set(docRef, item.toJson(), SetOptions(merge: true));
  }

  @override
  void update({
    required String path,
    required Map<String, dynamic> data,
  }) {
    final DocumentReference docRef = _firestoreInstance.doc(path);
    _batch.update(docRef, data);
  }

  @override
  void delete({required String path}) {
    final DocumentReference docRef = _firestoreInstance.doc(path);
    _batch.delete(docRef);
  }
}
