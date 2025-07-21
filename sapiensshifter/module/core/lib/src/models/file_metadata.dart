class FileMetadata {
  final String path;

  final int size;

  final String? mimeType;

  final DateTime createdAt;

  final DateTime updatedAt;

  FileMetadata({
    required this.path,
    required this.size,
    this.mimeType,
    required this.createdAt,
    required this.updatedAt,
  });
}
