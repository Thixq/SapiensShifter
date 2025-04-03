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
          child: Badge(
            padding: EdgeInsets.all(8.sp),
            alignment: Alignment.bottomLeft,
            label: const Text('9'),
          ),
        ),
      ],
    );
  }
}
