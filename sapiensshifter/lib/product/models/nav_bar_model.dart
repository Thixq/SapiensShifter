import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show IconData;

final class NavBarItem extends Equatable {
  const NavBarItem({required this.icon, this.onPress});

  final IconData icon;
  final void Function()? onPress;

  @override
  List<Object?> get props => [icon];
}
