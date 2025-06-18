class WeekPeriod {
  WeekPeriod({
    required this.weekNumber,
    required this.start,
    required this.end,
  });
  final int weekNumber;
  final DateTime start;
  final DateTime end;

  @override
  String toString() {
    return 'Week $weekNumber: ${formatDate(start)} - ${formatDate(end)}';
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
