class FileMetadata {
  /// The file's unique path or identifier.
  final String path;

  /// Size of the file in bytes.
  final int size;

  /// MIME type of the file, if known.
  final String? mimeType;

  /// Timestamp when the file was created.
  final DateTime createdAt;

  /// Timestamp when the file was last modified.
  final DateTime updatedAt;

  FileMetadata({
    required this.path,
    required this.size,
    this.mimeType,
    required this.createdAt,
    required this.updatedAt,
  });
}
