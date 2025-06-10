// ignore_for_file: must_be_immutable

part of '../order_detail_view.dart';

@immutable
final class OptionWidget extends StatelessWidget {
  OptionWidget({required this.extra, required this.optionChange, super.key});

  final ExtrasModel extra;
  final void Function(double, double, ExtrasModel, String) optionChange;

  double _previousPrice = 0;
  double _currentPrice = 0;

  List<CustomRadioModel<String>> get _optionsFromWidget {
    final options = extra.allOptionsMapEntry;
    return options?.entries
            .map(
              (e) => CustomRadioModel(
                widget: Text(
                  e.key.sapiExt.textLocale(LocalizationPathEnum.options),
                ),
                value: e.key,
              ),
            )
            .toList()
            .cast<CustomRadioModel<String>>() ??
        [];
  }

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
        CustomRadioViewer<String>(
          radioDecoration: _buildDecoration(context),
          itemList: _optionsFromWidget,
          onChange: (value) {
            final price = extra.allOptionsMapEntry?.entries
                .firstWhere(
                  (element) => element.key == value,
                )
                .value;
            if (_currentPrice != price) {
              _previousPrice = _currentPrice;
              _currentPrice = price ?? 0;
            }
            optionChange(_previousPrice, _currentPrice, extra, value);
            _previousPrice = _currentPrice;
          },
        ),
      ],
    );
  }

  CustomRadioDecoration _buildDecoration(BuildContext context) {
    return CustomRadioDecoration(
      selectedColor: context.general.colorScheme.primary,
      padding: EdgeInsets.symmetric(
        horizontal: context.sized.normalValue,
        vertical: context.sized.lowValue,
      ),
      borderRadius: BorderRadius.circular(context.sized.normalValue),
    );
  }
}
