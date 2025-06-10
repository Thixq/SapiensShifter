part of '../order_detail_view.dart';

class Body extends StatelessWidget {
  const Body({
    required this.deliveryOptions,
    required this.optionChange,
    required this.deliveryChange,
    required this.onSumbit,
    super.key,
  });

  final List<CustomRadioModel<DeliveryStatus>> deliveryOptions;
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
    return BlocBuilder<OrderDetailViewModel, OrderDetailState>(
      buildWhen: (previous, current) =>
          current.extrasList.isNotEmpty &&
          previous.extrasList != current.extrasList,
      builder: (context, state) {
        return Flexible(
          child: SingleChildScrollView(
            child: SeparatorListWidget(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.extrasList
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
      },
    );
  }
}
