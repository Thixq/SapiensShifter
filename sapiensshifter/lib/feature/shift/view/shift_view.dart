import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';

@RoutePage()
class ShiftView extends StatefulWidget {
  const ShiftView({super.key});

  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends BaseState<ShiftView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
