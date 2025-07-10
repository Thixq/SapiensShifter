part of '../shift_add_view.dart';

final _weekLocalization = <String>[
  LocaleKeys.date_week_days_monday.tr(),
  LocaleKeys.date_week_days_tuesday.tr(),
  LocaleKeys.date_week_days_wednesday.tr(),
  LocaleKeys.date_week_days_thursday.tr(),
  LocaleKeys.date_week_days_friday.tr(),
  LocaleKeys.date_week_days_saturday.tr(),
  LocaleKeys.date_week_days_sunday.tr(),
];

class ShiftAddContent extends StatelessWidget {
  const ShiftAddContent({
    required this.formKey,
    required this.onWeekPeriod,
    required this.peopleMap,
    required this.onConfrim,
    required this.onPeople,
    required this.onShiftDay,
    required this.branchs,
    required this.shifts,
    required this.shiftMaps,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final void Function(WeekPeriod weekPeriod) onWeekPeriod;
  final void Function(String? peopleId) onPeople;
  final List<UserPreviewModel> peopleMap;
  final VoidCallback onConfrim;
  final void Function(ShiftDay shiftDay, int index) onShiftDay;
  final List<BranchModel> branchs;
  final List<ShiftStatusModel> shifts;
  final Map<int, ShiftDay> shiftMaps;

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
              ...shiftMaps.entries.map(
                (entry) {
                  final index = entry.key;
                  final shiftDay = entry.value;
                  return BranchAndShift(
                    title: _weekLocalization[index],
                    branch: branchs,
                    shift: shifts,
                    index: index,
                    shiftDay: shiftDay,
                    onShiftDay: onShiftDay,
                  );
                },
              ),
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
