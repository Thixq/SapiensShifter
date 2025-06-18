part of '../shift_view.dart';

class ShiftViewShiftCalendar extends StatelessWidget with MonthFullWeeksMixin {
  const ShiftViewShiftCalendar({
    required this.shiftList,
    super.key,
  });

  final List<ShiftDay> shiftList;

  List<DayCard> _generateShift({int weekCount = 6}) {
    final shiftMap = Map.fromEntries(
      shiftList.map(
        (shift) => MapEntry(
          DateUtils.dateOnly(shift.time ?? DateTime(2002, 06, 30)),
          shift,
        ),
      ),
    );

    final startTime = getCurrentMonthFullWeeksRange().start;

    return List.generate(weekCount * 7, (i) {
      final toDay = startTime.add(Duration(days: i));
      final dayKey = DateUtils.dateOnly(toDay);
      final shiftDay = shiftMap[dayKey] ?? ShiftDay(time: toDay);
      return DayCard(shiftDay: shiftDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(context.sized.normalValue),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _generateShift().length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: context.sized.normalValue,
            crossAxisSpacing: context.sized.normalValue,
            childAspectRatio: 3 / 5,
          ),
          itemBuilder: (context, index) => _generateShift()[index],
        ),
      ),
    );
  }
}
