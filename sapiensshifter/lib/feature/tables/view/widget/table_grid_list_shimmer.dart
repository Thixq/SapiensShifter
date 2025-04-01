part of '../tables_view.dart';

class TableGridListShimmer extends StatelessWidget {
  const TableGridListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.sized.normalValue,
        mainAxisSpacing: context.sized.normalValue,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Shimmer(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade400, Colors.white60],
          ),
          child: const PreviewTableCard(
            tableModel: TableModel(),
          ),
        );
      },
    );
  }
}
