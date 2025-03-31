part of '../tables_view.dart';

class TableGrid extends StatelessWidget {
  const TableGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Her satırda 2 sütun olacak
        crossAxisSpacing: context.sized.normalValue,
        mainAxisSpacing: context.sized.normalValue,
      ),
      itemCount: 16, // 10 eleman gösterecek
      itemBuilder: (context, index) {
        return PreviewTableCard(
          tableModel: TableModel(
            branchName: 'kanyon',
            creatorId: 'erdem',
            id: '12012025kanyonblabla',
            orderList: [
              const OrderModel(price: 12),
              const OrderModel(price: 12),
            ],
            peopleCount: 2,
            tableName: 'Masa1',
            timeStamp: DateTime.now(),
          ),
        );
      },
    );
  }
}
