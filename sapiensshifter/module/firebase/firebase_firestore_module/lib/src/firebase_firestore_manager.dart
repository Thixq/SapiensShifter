import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

import '../firebase_firestore_module.dart';

/// Manages Firestore network operations.
class FirebaseFirestoreManager extends INetworkManager {
  /// Private constructor that creates a manager using the given Firestore instance.
  FirebaseFirestoreManager._(FirebaseFirestore firestore)
      : super(
          FirebaseFirestoreOperation(
            firestore: firestore,
          ),
        );

  /// Returns a singleton instance using the default Firestore instance.
  static FirebaseFirestoreManager get instance =>
      FirebaseFirestoreManager._(FirebaseFirestore.instance);

  /// Returns a new instance with a specified Firestore instance.
  static FirebaseFirestoreManager instanceFor(FirebaseFirestore firestore) =>
      FirebaseFirestoreManager._(firestore);

  @override
  void init() {}
}
