abstract class LocalCacheOperationInterface {
  Future<bool> write<T>({required String key, required T value});
  Future<bool> writeAll({required Map<String, dynamic> items});
  Future<MapEntry<String, T>> getValue<T>({required String key});
  Future<Map<String, dynamic>> getAllValue();
  Future<bool> delete({required String key});
  Future<bool> updateValue({required String key, required dynamic newValue});
}
