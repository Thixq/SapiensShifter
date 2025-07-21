part of '../view/order_detail_view.dart';

mixin OrderDetailMixin on BaseState<OrderDetailView> {
  late final OrderDetailViewModel _detailViewModel;

  OrderDetailViewModel get viewModel => _detailViewModel;

  late List<ExtrasModel> extrasList;

  @override
  void initState() {
    _detailViewModel = OrderDetailViewModel(
      OrderDetailState.initial(
        order: OrderModel(
          id: const UuidV7().generate(),
          price: widget.product.price,
          orderName: widget.product.productName,
          imagePath: widget.product.imagePath,
        ),
      ),
      networkManager: ProductConfigureItems.networkManager,
    );
    _detailViewModel.getExtras(optionsId: widget.product.productOptions);
    super.initState();
  }

  List<CustomRadioModel<DeliveryStatus>> get deliveryOptions => [
        CustomRadioModel(
          widget: SvgAssetBuilder(
            builderSize: Size(24.sp, 24.sp),
            svgPath: AssetsPathConstant.hereIn,
          ),
          value: DeliveryStatus.HERE_IN,
        ),
        CustomRadioModel(
          widget: SvgAssetBuilder(
            builderSize: Size(24.sp, 24.sp),
            svgPath: AssetsPathConstant.takeAway,
          ),
          value: DeliveryStatus.TAKE_AWAY,
        ),
      ];

  @override
  void dispose() {
    _detailViewModel.close();
    super.dispose();
  }
}
