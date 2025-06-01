import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/order_hisorty_view/mixin/order_history_mixin.dart';
import 'package:sapiensshifter/feature/order_hisorty_view/view_model/order_history_view_model.dart';
import 'package:sapiensshifter/feature/order_hisorty_view/view_model/state/order_history_state.dart';
import 'package:sapiensshifter/product/component/preview_order_card.dart';
import 'package:sapiensshifter/product/models/order_model/order_model.dart';
import 'package:sapiensshifter/product/models/table_model/table_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/table_preview.dart';

@RoutePage()
class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends BaseState<OrderHistoryView>
    with OrderHistoryMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sipariş Listesi'),
        ),
        body: _buildListTables(context),
      ),
    );
  }

  Widget _buildListTables(BuildContext context) {
    return BlocBuilder<OrderHistoryViewModel, OrderHistoryState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.only(
            left: context.sized.lowValue,
            right: context.sized.lowValue,
            top: context.sized.mediumValue,
            bottom: context.sized.mediumValue,
          ),
          itemCount: state.tables.length,
          separatorBuilder: (context, index) => SizedBox(
            height: context.sized.lowValue,
          ),
          itemBuilder: (context, index) =>
              _buildTableList(context, index, state),
        );
      },
    );
  }

  Widget? _buildTableList(
    BuildContext context,
    int index,
    OrderHistoryState state,
  ) {
    if (state.tables.isNotEmpty) {
      return TablePreview(
        table: state.tables[index],
        onDissimableOrder: (order) {
          viewModel.orderClose(
            tableId: state.tables[index].id ?? '-1',
            orderId: order.id ?? '-1',
          );
        },
        onDissimableTable: (table) {
          viewModel.tableClose(tableId: table.id ?? '-1');
        },
      );
    }
    return null;
  }
}
