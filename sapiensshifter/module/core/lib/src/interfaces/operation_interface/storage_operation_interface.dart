import 'dart:io';
import 'dart:typed_data';

import 'package:core/src/models/file_metadata.dart';

abstract class IStorageOperation {
  Future<String?> upload({
    Uint8List? byteFile,
    File? file,
    required String path,
    String? mimeType,
  });
  Future<Uint8List?> download({required String path});
  Future<List<String>> listFiles();
  Future<void> deleteFile(String path);
  Future<FileMetadata> getMetadata(String path);
  Future<void> moveFile({
    required String oldPath,
    required String newPath,
  });
  Future<void> copyFile({
    required String sourcePath,
    required String destinationPath,
  });
  Future<void> clear({
    String path = '',
  });
}
