part of '../tables_view.dart';

class TableGrid extends StatelessWidget {
  const TableGrid({
    required this.tableList,
    required this.onPress,
    super.key,
  });

  final List<TableModel> tableList;
  final void Function(TableModel? table) onPress;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.sized.normalValue,
        mainAxisSpacing: context.sized.normalValue,
      ),
      itemCount: tableList.length,
      itemBuilder: (context, index) {
        return PreviewTableCard(
          tableModel: tableList[index],
          onPressed: onPress,
        );
      },
    );
  }
}
