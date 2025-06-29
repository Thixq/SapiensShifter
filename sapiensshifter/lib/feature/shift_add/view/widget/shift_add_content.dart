part of '../shift_add_view.dart';

final _weelLocalization = <String>[
  LocaleKeys.date_week_days_monday.tr(),
  LocaleKeys.date_week_days_tuesday.tr(),
  LocaleKeys.date_week_days_wednesday.tr(),
  LocaleKeys.date_week_days_thursday.tr(),
  LocaleKeys.date_week_days_friday.tr(),
  LocaleKeys.date_week_days_saturday.tr(),
  LocaleKeys.date_week_days_sunday.tr(),
];

class ShiftAddContent extends StatelessWidget {
  ShiftAddContent({
    required this.formKey,
    required this.onWeekPeriod,
    required this.peopleMap,
    required this.onConfrim,
    required this.onPeople,
    required this.onShiftDay,
    required this.branchs,
    required this.shifts,
    super.key,
  }) : _week = List.generate(
          7,
          (index) => BranchAndShift(
            title: _weelLocalization[index],
            index: index,
            onShiftDay: onShiftDay,
            branch: branchs,
            shift: shifts,
          ),
        );

  final GlobalKey<FormState> formKey;
  final void Function(WeekPeriod weekPeriod) onWeekPeriod;
  final void Function(String? peopleId) onPeople;
  final List<UserPreviewModel> peopleMap;
  final VoidCallback onConfrim;
  final void Function(ShiftDay shiftDay, int index) onShiftDay;
  final List<BranchModel> branchs;
  final List<ShiftStatusModel> shifts;
  final List<BranchAndShift> _week;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: SeparatorListWidget(
            separator: context.sized.emptySizedHeightBoxLow,
            children: [
              WeeklyPeriod(
                onChange: onWeekPeriod,
              ),
              SapiCustomDropDown<String>(
                validator: SapiDropDownValidator.emptyValidator<String>,
                hintText: LocaleKeys.page_sihft_add_view_choice_people.tr(),
                items: peopleMap
                    .map(
                      (people) => SapiDropDownModel<String>(
                        displayName: people.name,
                        value: people.userId,
                      ),
                    )
                    .toList(),
                onSelected: onPeople,
              ),
              ..._week,
              SizedBox(
                width: double.infinity,
                child: SapiButton(
                  buttonText: LocaleKeys.confirm.tr(),
                  onPressed: onConfrim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
