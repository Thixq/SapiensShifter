part of '../order_detail_view.dart';

class SumbitButton extends StatelessWidget {
  const SumbitButton({required this.onSumbit, super.key});

  final VoidCallback onSumbit;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.spa),
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<OrderDetailViewModel, OrderDetailState>(
            builder: (context, state) {
              return SapiButton(
                buttonText:
                    '${LocaleKeys.done.tr()} ${state.order.price.sapiDoubleExt.priceFraction}'
                        .sapiExt
                        .priceSymbol,
                onPressed: onSumbit,
              );
            },
          ),
        ),
      ),
    );
  }
}
