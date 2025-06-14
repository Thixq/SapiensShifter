import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift_add/mixin/shift_add_mixin.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/shift_add_app_bar.dart';
part 'widget/branch_and_shift.dart';

@RoutePage()
class ShiftAddView extends StatefulWidget {
  const ShiftAddView({super.key});

  @override
  State<ShiftAddView> createState() => _ShiftAddViewState();
}

class _ShiftAddViewState extends BaseState<ShiftAddView> with ShiftAddMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ShiftAddAppBar(),
      body: BranchAndShift(),
    );
  }
}
