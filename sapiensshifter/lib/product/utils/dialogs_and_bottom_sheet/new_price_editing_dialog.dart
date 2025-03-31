import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/input_formatters/decimal_input_formatter.dart';

class NewPriceEditingDialog extends StatefulWidget {
  const NewPriceEditingDialog({
    required this.initalPrice,
    required this.title,
    super.key,
  });

  final double initalPrice;
  final String title;
  static Future<double?> show(
    BuildContext context, {
    required double initalPrice,
    required String title,
  }) {
    return showDialog<double?>(
      context: context,
      builder: (context) => NewPriceEditingDialog(
        initalPrice: initalPrice,
        title: title,
      ),
    );
  }

  @override
  State<NewPriceEditingDialog> createState() => _NewPriceEditingDialogState();
}

class _NewPriceEditingDialogState extends State<NewPriceEditingDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.text =
        widget.initalPrice.sapiDoubleExt.priceFraction!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 22.h,
        child: Padding(
          padding: context.padding.low,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitle(widget.title),
              _buildChangePrice(context),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildTitle(String title) => Text(title);

  Row _buildChangePrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.initalPrice.sapiDoubleExt.priceFraction!.sapiExt.priceSymbol,
        ),
        const Icon(Icons.arrow_forward_outlined),
        SizedBox(
          width: 80,
          child: TextField(
            inputFormatters: [
              DecimalInputFormatter(100),
              LengthLimitingTextInputFormatter(7),
            ],
            style: context.general.textTheme.titleLarge,
            keyboardType: TextInputType.number,
            controller: _textEditingController,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Align _buildButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: FilledButton(
        onPressed: () {
          context.route.pop(double.tryParse(_textEditingController.text));
        },
        child: Text(LocaleKeys.confirm.tr()),
      ),
    );
  }
}
