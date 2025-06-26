// ignore_for_file: constant_identifier_names

class AssetsPathConstant {
  // base path
  static const _baseLogoPath = 'assets/logo';
  static const _baseImagePath = 'assets/images';
  static const _baseSocialPath = 'assets/icon/social_sign_ic';
  static const _baseDeliveryIconPath = 'assets/icon/order_status_ic';

  // logo
  static const sapiensLogo = '$_baseLogoPath/coffee_sapiens_logo.svg';
  static const productPlaceHolder = 'assets/icon/product_placeholder.svg';

  //delivery status icon
  static const hereIn = '$_baseDeliveryIconPath/ic_here_in.svg';
  static const takeAway = '$_baseDeliveryIconPath/ic_take_away.svg';
  static const orderStatus = '$_baseDeliveryIconPath/ic_no_coffee.svg';

  //image
  static const onboard_orderImage =
      '$_baseImagePath/onboard/onboard_order_image.png';
  static const onboard_shiftImage =
      '$_baseImagePath/onboard/onboard_shift_image.png';
  static const onboard_warehouseImage =
      '$_baseImagePath/onboard/onboard_warehouse_image.png';

  // social logo path
  static const social_google = '$_baseSocialPath/logo_google.svg';
  static const social_apple = '$_baseSocialPath/logo_apple.svg';
  static const social_facebook = '$_baseSocialPath/logo_facebook.svg';
}
