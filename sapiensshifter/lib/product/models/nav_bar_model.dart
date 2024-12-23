import 'package:flutter/material.dart' show IconData;

class NavBarItem {
  NavBarItem({required this.icon, this.onPress});

  final IconData icon;
  final void Function()? onPress;
}
