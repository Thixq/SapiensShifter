// ignore_for_file: parameter_assignments

import 'package:sapiensshifter/product/models/week_period/week_period.dart';

mixin class MonthFullWeeksMixin {
  ({DateTime start, DateTime end}) getCurrentMonthFullWeeksRange({
    DateTime? date,
  }) {
    date ??= DateTime.now();

    final year = date.year;
    final month = date.month;
    final firstDayOfMonth = DateTime(year, month);
    final startDate = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1),
    );
    final lastDayOfMonth = DateTime(year, month + 1);
    final endDate = lastDayOfMonth.add(
      Duration(days: 7 - lastDayOfMonth.weekday),
    );
    return (start: startDate, end: endDate);
  }

  List<WeekPeriod> generateWeeklyPeriods(int? year) {
    year ??= DateTime.now().year;
    final janFirst = DateTime(year);
    var start =
        janFirst.subtract(Duration(days: janFirst.weekday - DateTime.monday));

    final decLast = DateTime(year, 12, 31);
    final endLimit =
        decLast.add(Duration(days: DateTime.sunday - decLast.weekday));

    final weeks = <WeekPeriod>[];
    var weekNumber = 1;

    while (start.isBefore(endLimit) || start.isAtSameMomentAs(endLimit)) {
      final end = start.add(const Duration(days: 6));
      weeks.add(WeekPeriod(weekNumber: weekNumber, start: start, end: end));
      weekNumber++;
      start = start.add(const Duration(days: 7));
    }

    return weeks;
  }
}
