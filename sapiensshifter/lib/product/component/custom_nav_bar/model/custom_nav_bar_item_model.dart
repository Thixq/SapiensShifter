part of '../custom_nav_bar.dart';

final class NavBarItem {
  NavBarItem({required this.icon, this.onPress});

  final IconData icon;
  final VoidCallback? onPress;
}
