// ignore_for_file: inference_failure_on_instance_creation

part of '../product_price_edit_view.dart';

class ShimmerPriceOption extends StatelessWidget {
  const ShimmerPriceOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [Colors.grey.shade400, Colors.white]),
      child: Column(
        children: [
          ProductPriceOptionView(
            onChange: (value) {},
            options: Map.fromIterable(
              List.generate(
                5,
                (index) => 'index: $index',
              ),
            ),
          ),
          const Divider(),
          ProductPriceOptionView(
            onChange: (value) {},
            options: Map.fromIterable(
              List.generate(
                5,
                (index) => 'index:$index',
              ),
            ),
          ),
          CheckboxListTile.adaptive(
            title: Container(
              width: 24,
              height: 16,
              color: Colors.blue,
            ),
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
