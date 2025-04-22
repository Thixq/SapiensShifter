import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/core/state/view_model/product_state.dart';
import 'package:sapiensshifter/core/utils/func/network_connection_status.dart';

class ProductViewModel extends BaseCubit<ProductState>
    with NetworkConnectionStatus {
  ProductViewModel() : super(const ProductState());

  /// Checking network connection.
  bool isNetworkCheck() => isNetworkCheck();

  /// Change theme mode.
  /// [themeMode] is [ThemeMode.light] or [ThemeMode.dark]
  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }
}
