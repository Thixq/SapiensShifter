import 'package:flutter/widgets.dart';

class BasicListTileModel {
  BasicListTileModel({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
}
