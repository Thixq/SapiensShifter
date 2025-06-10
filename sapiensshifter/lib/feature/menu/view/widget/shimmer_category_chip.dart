part of '../menu_view.dart';

class ShimmerCategoryChip extends StatelessWidget {
  const ShimmerCategoryChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [Colors.grey.shade400, Colors.white]),
      child: CustomRadioViewer(
        itemList: List.generate(
          6,
          (index) =>
              CustomRadioModel(widget: Text('index: $index'), value: index),
        ),
        onChange: (value) {},
        isWrap: false,
      ),
    );
  }
}
