import 'package:core/src/interfaces/interface.dart';

abstract class ILocalCacheManager {
  const ILocalCacheManager({this.path, required this.cacheOperation});

  Future<void> init();
  Future<bool> remove();

  final String? path;
  final ILocalCacheOperation cacheOperation;
}
