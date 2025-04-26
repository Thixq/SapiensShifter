mixin MonthFullWeeksMixin {
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
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final endDate = lastDayOfMonth.add(
      Duration(days: 7 - lastDayOfMonth.weekday),
    );
    return (start: startDate, end: endDate);
  }
}
