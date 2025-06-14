import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/localization/localization_codegen/locale_keys.g.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift_add/mixin/shift_add_mixin.dart';

part 'widget/shift_add_app_bar.dart';

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
    );
  }
}
