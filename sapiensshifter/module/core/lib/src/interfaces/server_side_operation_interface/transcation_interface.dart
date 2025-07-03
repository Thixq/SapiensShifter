import 'package:core/core.dart';

abstract class ITransaction {
  Future<T> get<T extends IBaseModel<T>>({
    required String path,
    required T model,
  });

  void set<T extends IBaseModel<T>>({
    required String path,
    required T item,
  });

  void update({
    required String path,
    required Map<String, dynamic> data,
  });

  void delete({required String path});
}
