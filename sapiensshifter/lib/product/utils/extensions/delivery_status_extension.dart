import 'package:sapiensshifter/product/utils/enums/delivery_status.dart';

extension DeliveryStatusExtension on DeliveryStatus {
  String get _basePath => 'assets/icon';
  String get deliveryPath {
    switch (this) {
      case DeliveryStatus.HERE_IN:
        return '$_basePath/ic_here_in.svg';
      case DeliveryStatus.TAKE_AWAY:
        return '$_basePath/ic_take_away.svg';
    }
  }
}
