import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift_add/mixin/shift_add_mixin.dart';
import 'package:sapiensshifter/feature/shift_add/view_model/shift_add_view_model.dart';
import 'package:sapiensshifter/feature/shift_add/view_model/state/shift_add_state.dart';
import 'package:sapiensshifter/product/component/weekly_period.dart';
import 'package:sapiensshifter/product/models/week_period/week_period.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';
import 'package:sapiensshifter/product/utils/validator/generic_validator.dart';

part 'widget/shift_add_app_bar.dart';
part 'widget/branch_and_shift.dart';
part 'widget/shift_add_content.dart';

@RoutePage()
class ShiftAddView extends StatefulWidget {
  const ShiftAddView({super.key});

  @override
  State<ShiftAddView> createState() => _ShiftAddViewState();
}

class _ShiftAddViewState extends BaseState<ShiftAddView> with ShiftAddMixin {
  String? _peopleId = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: const ShiftAddAppBar(),
        body: BlocBuilder<ShiftAddViewModel, ShiftAddState>(
          builder: (context, state) => Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.sized.normalValue),
            child: ShiftAddContent(
              formKey: formKey,
              onWeekPeriod: (weekPeriod) {
                viewModel.shiftWeek(weekPeriod: weekPeriod);
              },
              peopleMap: state.peoples,
              onPeople: (peopleId) {
                _peopleId = peopleId;
              },
              branchs: state.branchs,
              shifts: state.shifts,
              onShiftDay: (shiftDay, index) {
                viewModel.addDay(day: shiftDay, index: index);
              },
              onConfrim: () {
                if (formKey.currentState?.validate() ?? false) {
                  viewModel.shiftAdd(peopleId: _peopleId ?? '-1');
                }
                showSnakeToastMessage(
                  context,
                  message:
                      LocaleKeys.page_sihft_add_view_show_toast_message.tr(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
