import 'package:core/core.dart';
import 'package:sharhed_preferences_module/sharhed_preferences_module.dart';

final class SharedPreferencesManager extends ILocalCacheManager {
  SharedPreferencesManager._(
      {required SharedPreferencesOperation sharedPreferencesOperation})
      : super(cacheOperation: sharedPreferencesOperation);

  static SharedPreferencesManager get instace => SharedPreferencesManager._(
      sharedPreferencesOperation: SharedPreferencesOperation.instance);

  @override
  Future<void> init() async {
    throw UnimplementedError(
        'SharedPreferencesManager does not require initialization.');
  }

  @override
  Future<bool> remove() async {
    throw UnimplementedError(
        'SharedPreferencesManager does not support remove operation.');
  }
}
