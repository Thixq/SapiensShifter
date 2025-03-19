import 'package:core/core.dart';

final class SharedPreferencesManager extends ILocalCacheManager {
  SharedPreferencesManager({required super.cacheOperation, super.path});

  @override
  Future<void> init() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove() {
    throw UnimplementedError();
  }
}
