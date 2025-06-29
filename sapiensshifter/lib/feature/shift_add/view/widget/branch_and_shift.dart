// ignore_for_file: avoid_field_initializers_in_const_classes, must_be_immutable

part of '../shift_add_view.dart';

class BranchAndShift extends StatelessWidget {
  BranchAndShift({
    required this.title,
    required this.branch,
    required this.shift,
    required this.index,
    required this.onShiftDay,
    super.key,
  }) : _shiftDay = const ShiftDay();

  final String title;
  final int index;
  final List<BranchModel> branch;
  final List<ShiftStatusModel> shift;
  ShiftDay _shiftDay;
  final void Function(ShiftDay shiftDay, int index) onShiftDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        context.sized.emptySizedHeightBoxLow,
        Row(
          children: [
            Expanded(
              child: SapiCustomDropDown<String>(
                validator: SapiDropDownValidator.emptyValidator,
                hintText:
                    LocaleKeys.page_sihft_add_view_branch_and_shift_shift.tr(),
                items: shift
                    .map(
                      (status) => SapiDropDownModel<String>(
                        displayName: status.status?.localization.tr(),
                        value: status.id,
                      ),
                    )
                    .toList(),
                onSelected: (shift) {
                  _shiftDay = _shiftDay.copyWith(shiftStatusId: shift);
                  onShiftDay(
                    _shiftDay,
                    index,
                  );
                },
              ),
            ),
            context.sized.emptySizedWidthBoxLow3x,
            Expanded(
              child: SapiCustomDropDown<String>(
                validator: SapiDropDownValidator.emptyValidator,
                hintText:
                    LocaleKeys.page_sihft_add_view_branch_and_shift_branch.tr(),
                items: branch
                    .map(
                      (brach) => SapiDropDownModel<String>(
                        displayName: brach.name,
                        value: brach.id,
                      ),
                    )
                    .toList(),
                onSelected: (branch) {
                  _shiftDay = _shiftDay.copyWith(branchId: branch);
                  onShiftDay(_shiftDay, index);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
