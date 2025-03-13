import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/product_configure_items.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sapiensshifter/core/utils/mixin/func/network_connection_status.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with NetworkConnectionStatus {
  ProductViewModel get productViewModel =>
      ProductConfigureItems.productViewModel;
}
