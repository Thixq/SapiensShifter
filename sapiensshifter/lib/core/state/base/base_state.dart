import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/view_model/product_view_model.dart';
import 'package:sapiensshifter/core/utils/func/network_connection_status.dart';
import 'package:sapiensshifter/core/utils/mixin/exception/show_excepiton_dialog/show_exception_dialog.dart';
import 'package:sapiensshifter/core/utils/mixin/show_toast_message/toast_message_mixin.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with NetworkConnectionStatus, ShowExceptionDialogMixin, ToastMessageMixin {
  ProductViewModel get productViewModel =>
      ProductConfigureItems.productViewModel;
}
