part of '../order_detail_view.dart';

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({
    required this.deliveryOptions,
    required this.deliveryChange,
    super.key,
  });

  final List<CustomRadioModel<DeliveryStatus>> deliveryOptions;
  final ValueChanged<DeliveryStatus> deliveryChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.page_order_detail_service_type.tr(),
          style: context.general.textTheme.titleMedium,
        ),
        context.sized.emptySizedHeightBoxLow,
        CustomRadioViewer(
          itemSize: 24.sp,
          spacing: 12.sp,
          itemList: deliveryOptions,
          onChange: deliveryChange,
        ),
      ],
    );
  }
}
