import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

extension DeliveryStatusExtension on DeliveryStatus? {
  String get _basePath => 'assets/icon/order_status_ic';
  String? get toDeliveryPath {
    switch (this) {
      case DeliveryStatus.HERE_IN:
        return '$_basePath/ic_here_in.svg';
      case DeliveryStatus.TAKE_AWAY:
        return '$_basePath/ic_take_away.svg';
      case null:
        return null;
    }
  }
}
