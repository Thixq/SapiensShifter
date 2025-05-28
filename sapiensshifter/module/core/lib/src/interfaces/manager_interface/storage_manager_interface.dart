import 'package:core/core.dart';

abstract class IStorageManager {
  void init();
  final String? basePath;
  final IStorageOperation storageOperation;

  IStorageManager({this.basePath, required this.storageOperation});
}
