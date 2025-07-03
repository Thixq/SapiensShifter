import 'package:core/src/interfaces/interface.dart';

abstract class ILocalCacheManager {
  const ILocalCacheManager({this.basePath, required this.cacheOperation});

  Future<void> init();
  Future<bool> remove();

  final String? basePath;
  final ILocalCacheOperation cacheOperation;
}
