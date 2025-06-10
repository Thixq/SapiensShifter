part of '../order_detail_view.dart';

class ShimmerOptionsList extends StatelessWidget {
  const ShimmerOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SeparatorListWidget(
        separator: context.sized.emptySizedHeightBoxLow,
        children: [_item(context), _item(context), _item(context)],
      ),
    );
  }

  Widget _item(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [Colors.grey.shade400, Colors.white]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 16.sp,
            width: 48.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.sized.mediumValue),
            ),
          ),
          context.sized.emptySizedHeightBoxLow,
          CustomRadioViewer(
            itemList: List.generate(
              5,
              (index) =>
                  CustomRadioModel(widget: Text('index: $index'), value: index),
            ),
            onChange: (value) {},
            radioDecoration: CustomRadioDecoration(
              selectedColor: context.general.colorScheme.primary,
              padding: EdgeInsets.symmetric(
                horizontal: context.sized.normalValue,
                vertical: context.sized.lowValue,
              ),
              borderRadius: BorderRadius.circular(context.sized.normalValue),
            ),
          ),
        ],
      ),
    );
  }
}
