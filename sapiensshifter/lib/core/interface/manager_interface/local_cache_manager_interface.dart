abstract class LocalCacheManagerInterface {
  const LocalCacheManagerInterface({this.path});
  Future<void> init();
  Future<bool> remove();
  final String? path;
}
