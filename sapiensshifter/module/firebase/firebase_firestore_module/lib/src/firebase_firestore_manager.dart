import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import '../firebase_firestore_module.dart';

class FirebaseFirestoreManager extends INetworkManager {
  FirebaseFirestoreManager._(FirebaseFirestore firestore)
      : super(
          FirebaseFirestoreOperation(
            firestore: firestore,
          ),
        );

  static FirebaseFirestoreManager get instance =>
      FirebaseFirestoreManager._(FirebaseFirestore.instance);

  static FirebaseFirestoreManager instanceFor(FirebaseFirestore firestore) =>
      FirebaseFirestoreManager._(firestore);

  @override
  void init() {
    throw UnimplementedError(
      'FirebaseFirestoreManager does not require initialization.',
    );
  }
}
