import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageOperation implements IStorageOperation {
  final FirebaseStorage _storage;

  FirebaseStorageOperation._({required FirebaseStorage instance})
    : _storage = instance;

  static FirebaseStorageOperation get instance =>
      instanceFor(FirebaseStorage.instance);

  static FirebaseStorageOperation instanceFor(FirebaseStorage instance) {
    return FirebaseStorageOperation._(instance: instance);
  }

  @override
  Future<String> upload({
    required Uint8List file,
    required String path,
    String? mimeType,
  }) async {
    return handleAsyncOperation(() async {
      final ref = _storage.ref().child(path);
      final metadata = SettableMetadata(contentType: mimeType);
      ref.putData(file, metadata);

      return await ref.getDownloadURL();
    });
  }

  @override
  Future<Uint8List?> download({required String path}) async {
    return handleAsyncOperation(() async {
      final ref = _storage.ref().child(path);
      return await ref.getData();
    });
  }

  @override
  Future<void> deleteFile(String path) async {
    return handleAsyncOperation(() async {
      final ref = _storage.ref().child(path);
      await ref.delete();
    });
  }

  @override
  Future<List<String>> listFiles({
    String path = '',
    bool recursive = false,
  }) async {
    return handleAsyncOperation(() async {
      final ref = _storage.ref().child(path);
      final result = await ref.listAll();
      return [
        ...result.items.map((item) => item.fullPath),
        if (recursive) ...result.prefixes.map((dir) => dir.fullPath),
      ];
    });
  }

  @override
  Future<FileMetadata> getMetadata(String path) async {
    return handleAsyncOperation(() async {
      final ref = _storage.ref().child(path);
      final metadata = await ref.getMetadata();
      return FileMetadata(
        path: path,
        size: metadata.size ?? 0,
        mimeType: metadata.contentType,
        createdAt: metadata.timeCreated ?? DateTime.now(),
        updatedAt: metadata.updated ?? DateTime.now(),
      );
    });
  }

  @override
  Future<void> moveFile({
    required String oldPath,
    required String newPath,
  }) async {
    return handleAsyncOperation(() async {
      final oldRef = _storage.ref().child(oldPath);
      final data = await oldRef.getData();
      final metadata = await oldRef.getMetadata();
      await upload(path: newPath, file: data!, mimeType: metadata.contentType);
      await oldRef.delete();
    });
  }

  @override
  Future<void> copyFile({
    required String sourcePath,
    required String destinationPath,
  }) async {
    return handleAsyncOperation(() async {
      final sourceRef = _storage.ref().child(sourcePath);
      final data = await sourceRef.getData();
      final metadata = await sourceRef.getMetadata();
      await upload(
        path: destinationPath,
        file: data!,
        mimeType: metadata.contentType,
      );
    });
  }

  @override
  Future<void> clear({String path = ''}) async {
    return handleAsyncOperation(() async {
      final files = await listFiles(path: path, recursive: true);
      for (final filePath in files) {
        await deleteFile(filePath);
      }
    });
  }
}
