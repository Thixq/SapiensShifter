import 'package:core/core.dart';

abstract class INetworkOperation {
  Future<T> getItem<T extends IBaseModel<T>>(
      {required String path, required T model, String? key});

  Future<List<T>> getItemsQuery<T extends IBaseModel<T>>({
    required String path,
    required T model,
    String? key,
    INetworkQuery? query,
  });

  Future<bool> itemExists({required String path});

  Future<bool> addItem<T extends IBaseModel<T>>({
    required String path,
    required T item,
  });

  Future<bool> addAllItem<T extends IBaseModel<T>>(
      {required String path, required List<T> items});

  Future<bool> update({
    required String path,
    required Map<String, dynamic> value,
  });

  Future<bool> updateAll<T extends IBaseModel<T>>({
    required String path,
    required List<T> items,
  });
  Future<bool> replaceItem<T extends IBaseModel<T>>({
    required String path,
    required T item,
    String? key,
  });

  Future<bool> deleteItem({required String path, String? key});

  Stream<T> getStream<T extends IBaseModel<T>>({
    required String path,
    required T model,
    String? key,
  });

  Stream<List<T>> getStreamQuery<T extends IBaseModel<T>>({
    required String path,
    required T model,
    String? key,
    INetworkQuery? query,
  });

  Future<void> runBatch(
      Future<void> Function(IBatchWriter batch) batchFunction);

  Future<T> runTransaction<T>(
    Future<T> Function(ITransaction transaction) transactionHandler,
  );
}
