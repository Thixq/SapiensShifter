import 'package:core/core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_module/firebase_storage_module.dart';

class FirebaseStorageManager extends IStorageManager {
  FirebaseStorageManager._({required FirebaseStorage firebaseStorage})
    : super(
        storageOperation: FirebaseStorageOperation.instanceFor(firebaseStorage),
      );
  static FirebaseStorageManager get instance =>
      FirebaseStorageManager._(firebaseStorage: FirebaseStorage.instance);
  static FirebaseStorageManager instanceFor(FirebaseStorage firebaseStorage) =>
      FirebaseStorageManager._(firebaseStorage: firebaseStorage);

  @override
  String? get basePath => throw UnimplementedError(
    'FirebaseStorageManager does not support basePath.',
  );

  @override
  void init() {
    throw UnimplementedError(
      'FirebaseStorageManager does not require initialization.',
    );
  }
}
