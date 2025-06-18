import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/shift/mixin/shift_view_mixin.dart';
import 'package:sapiensshifter/feature/shift/view_model/shift_view_model.dart';
import 'package:sapiensshifter/feature/shift/view_model/state/shift_view_state.dart';
import 'package:sapiensshifter/product/component/custom_avatar.dart';
import 'package:sapiensshifter/product/component/day_card.dart';
import 'package:sapiensshifter/product/constant/page_path_constant.dart';
import 'package:sapiensshifter/product/profile/profile.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

import 'package:sapiensshifter/product/utils/export_dependency_package/shift_export.dart';
import 'package:sapiensshifter/product/utils/mixin/func/month_full_weeks.dart';

part 'widget/shift_view_app_bar.dart';
part 'widget/shift_view_shift_calendar.dart';
part 'widget/to_day_title.dart';

@RoutePage()
class ShiftView extends StatefulWidget {
  const ShiftView({super.key});

  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends BaseState<ShiftView> with ShiftViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: ShiftViewAppBar(
          profile: profile,
        ),
        body: Padding(
          padding: EdgeInsets.all(context.sized.normalValue),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      children: [
        const ToDayTitle(),
        SizedBox(height: context.sized.normalValue),
        BlocBuilder<ShiftViewModel, ShiftViewState>(
          builder: (context, state) {
            return ShiftViewShiftCalendar(
              shiftList: state.shifts,
            );
          },
        ),
      ],
    );
  }
}
