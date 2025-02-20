import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import '../firebase_firestore_module.dart';

class FirebaseFirestoreManager extends INetworkManager {
  /// If you want to use a different database,
  /// you can provide a new database using the [FirebaseFirestore.instanceFor] method.
  FirebaseFirestoreManager({FirebaseFirestore? fireStore})
      : super(FirebaseFirestoreOperation(
          firestore: fireStore ?? FirebaseFirestore.instance,
        ));

  @override
  void init() {}
}
