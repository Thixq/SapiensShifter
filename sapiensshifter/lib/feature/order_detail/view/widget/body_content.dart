part of '../order_detail_view.dart';

class Body extends StatelessWidget {
  const Body({
    required this.deliveryOptions,
    required this.optionChange,
    required this.extrasList,
    required this.deliveryChange,
    required this.onSumbit,
    super.key,
  });

  final List<CustomRadioModel<DeliveryStatus>> deliveryOptions;
  final Future<List<ExtrasModel>> extrasList;
  final void Function(
    double previousPrice,
    double currentPrice,
    ExtrasModel extra,
    String option,
  ) optionChange;
  final ValueChanged<DeliveryStatus> deliveryChange;
  final VoidCallback onSumbit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 24.spa,
          left: context.sized.lowValue,
          right: context.sized.lowValue,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: _options(context),
      ),
    );
  }

  SeparatorListWidget _options(BuildContext context) {
    return SeparatorListWidget(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      separator: context.sized.emptySizedHeightBoxLow,
      children: [
        DeliveryOptions(
          deliveryOptions: deliveryOptions,
          deliveryChange: deliveryChange,
        ),
        _buildOptionsList(context),
        SumbitButton(
          onSumbit: onSumbit,
        ),
      ],
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return FutureBuilder<List<ExtrasModel>>(
      future: extrasList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: ShimmerOptionsList());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Flexible(
            child: SingleChildScrollView(
              child: SeparatorListWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data!
                    .map(
                      (e) => OptionWidget(
                        extra: e,
                        optionChange: optionChange,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
        return const Expanded(child: ShimmerOptionsList());
      },
    );
  }
}
