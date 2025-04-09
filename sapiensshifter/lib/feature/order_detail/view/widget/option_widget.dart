// ignore_for_file: must_be_immutable

part of '../order_detail_view.dart';

@immutable
final class OptionWidget extends StatelessWidget {
  OptionWidget({required this.extra, required this.optionChange, super.key});

  final ExtrasModel extra;
  final void Function(double, double, ExtrasModel, String) optionChange;

  double _previousPrice = 0;
  double _currentPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<OrderDetailViewModel, OrderDetailState>(
          builder: (context, state) {
            return RichText(
              text: TextSpan(
                text:
                    extra.name.sapiExt.textLocale(LocalizationPathEnum.options),
                style: context.general.textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: '  +$_currentPrice'.sapiExt.priceSymbol,
                    style: context.general.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            );
          },
        ),
        ChoiceChipList<double>(
          options: extra.allOptionsMapEntry,
          isWrap: true,
          onSelected: (value) {
            if (_currentPrice != value.value) {
              _previousPrice = _currentPrice;
              _currentPrice = value.value;
            }
            optionChange(_previousPrice, _currentPrice, extra, value.key);
            _previousPrice = _currentPrice;
          },
          localizationPathEnum: LocalizationPathEnum.options,
        ),
      ],
    );
  }
}
