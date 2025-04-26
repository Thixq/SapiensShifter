part of '../shift_view.dart';

class ShiftViewSihftCalendar extends StatelessWidget with MonthFullWeeksMixin {
  const ShiftViewSihftCalendar({
    required this.shiftList,
    super.key,
  });

  final List<ShiftDay> shiftList;

  List<WeekCard> _generateShift({int listCount = 35}) {
    final weekList = <WeekCard>[];
    final time = getCurrentMonthFullWeeksRange().start;
    for (var i = 0; i < listCount; i++) {
      final toDay = time.add(Duration(days: i));
      ShiftDay? matchingShiftDay;
      for (final element in shiftList) {
        if (DateUtils.isSameDay(element.time, toDay)) {
          matchingShiftDay = element;
          break;
        }
      }
      if (matchingShiftDay != null) {
        weekList.add(
          WeekCard(
            shiftDay: matchingShiftDay,
          ),
        );
      } else {
        weekList.add(
          WeekCard(
            shiftDay: ShiftDay(
              time: toDay,
            ),
          ),
        );
      }
    }
    return weekList;
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
