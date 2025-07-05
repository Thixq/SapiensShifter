part of '../order_history_view.dart';

class TablePreview extends StatelessWidget {
  const TablePreview({
    required this.table,
    required this.onDissimableOrder,
    required this.onDissimableTable,
    super.key,
  });

  final TableModel table;
  final ValueChanged<OrderModel> onDissimableOrder;
  final ValueChanged<TableModel> onDissimableTable;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: _buildSlidableActionButton(context),
      child: PreviewOrderCard(
        tableModel: table,
        onDissimableOrder: onDissimableOrder,
      ),
    );
  }

  ActionPane _buildSlidableActionButton(BuildContext context) {
    return ActionPane(
      motion: const ScrollMotion(),
      dismissible: DismissiblePane(
        onDismissed: () => onDissimableTable,
      ),
      children: [
        SlidableAction(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(context.sized.normalValue),
            right: Radius.circular(context.sized.normalValue),
          ),
          onPressed: (context) {
            onDissimableTable(table);
          },
          icon: Icons.currency_lira,
          label: LocaleKeys.payment.tr(),
          backgroundColor: context.general.colorScheme.primary,
          foregroundColor: context.general.colorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}
