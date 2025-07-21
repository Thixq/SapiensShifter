// ignore_for_file: avoid_field_initializers_in_const_classes, must_be_immutable

part of '../shift_add_view.dart';

const List<String> _blacklistedShiftIds = ['YJxscBGQdto3sSrfmiEP'];

class BranchAndShift extends StatelessWidget {
  const BranchAndShift({
    required this.title,
    required this.branch,
    required this.shift,
    required this.index,
    required this.onShiftDay,
    required this.shiftDay,
    super.key,
  });

  final String title;
  final int index;
  final List<BranchModel> branch;
  final List<ShiftStatusModel> shift;
  final ShiftDay shiftDay;
  final void Function(ShiftDay shiftDay, int index) onShiftDay;

  @override
  Widget build(BuildContext context) {
    final isBranchDisabled =
        _blacklistedShiftIds.contains(shiftDay.shiftStatusId);
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
                onSelected: (shiftId) {
                  final newShift = shiftDay.copyWith(
                    shiftStatusId: shiftId,
                    branchId: _blacklistedShiftIds.contains(shiftId)
                        ? null
                        : shiftDay.branchId,
                  );
                  onShiftDay(
                    newShift,
                    index,
                  );
                },
              ),
            ),
            context.sized.emptySizedWidthBoxLow3x,
            Expanded(
              child: SapiCustomDropDown<String>(
                enabled: !isBranchDisabled,
                validator: isBranchDisabled
                    ? null
                    : SapiDropDownValidator.emptyValidator,
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
                onSelected: (branchId) {
                  final newShift = shiftDay.copyWith(branchId: branchId);
                  onShiftDay(newShift, index);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
