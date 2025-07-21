part of '../home_view.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    required this.onChange,
    required this.navBarItem,
    this.initalIndex = 0,
    super.key,
  });

  final ValueChanged<int> onChange;
  final List<NavBarItem> navBarItem;
  final int initalIndex;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: context.general.mediaQuery.padding.bottom + 2.h,
        ),
        child: SizedBox(
          width: 65.sp,
          child: CustomNavBar(
            initalIndex: initalIndex,
            onChange: onChange,
            items: navBarItem,
          ),
        ),
      ),
    );
  }
}
