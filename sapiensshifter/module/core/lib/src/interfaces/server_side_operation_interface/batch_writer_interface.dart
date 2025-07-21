import 'package:core/core.dart';

abstract class IBatchWriter {
  void create<T extends IBaseModel<T>>({
    required String path,
    required T item,
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
