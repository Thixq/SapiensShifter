part of '../menu_view.dart';

class AddTableButton extends StatelessWidget {
  const AddTableButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        Positioned(
          top: -11.sp,
          right: -11.sp,
          child: _badge(),
        ),
      ],
    );
  }

  Widget _badge() {
    return BlocBuilder<MenuViewModel, MenuViewState>(
      buildWhen: (previous, current) =>
          current.table.orderList != previous.table.orderList,
      builder: (context, state) => Badge(
        padding: EdgeInsets.all(8.sp),
        alignment: Alignment.bottomLeft,
        label: Text('${state.table.orderList.length}'),
      ),
    );
  }
}
