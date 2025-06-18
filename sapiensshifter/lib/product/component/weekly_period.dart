// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:sapiensshifter/product/models/week_period/week_period.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/mixin/func/month_full_weeks.dart';

class WeeklyPeriod extends StatefulWidget {
  const WeeklyPeriod({required this.onChange, this.year, super.key});
  final int? year;
  final ValueChanged<WeekPeriod> onChange;

  @override
  _WeeklyPeriodState createState() => _WeeklyPeriodState();
}

class _WeeklyPeriodState extends State<WeeklyPeriod> {
  late final List<WeekPeriod> _weeks;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _weeks = MonthFullWeeksMixin().generateWeeklyPeriods(widget.year);
    final today = DateTime.now();
    _currentIndex = _weeks.indexWhere(
      (week) => !today.isBefore(week.start) && !today.isAfter(week.end),
    );
    if (_currentIndex < 0) {
      _currentIndex = 0;
    }
    widget.onChange(_weeks[_currentIndex]);
  }

  void _prevWeek() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        widget.onChange(_weeks[_currentIndex]);
      }
    });
  }

  void _nextWeek() {
    setState(() {
      if (_currentIndex < _weeks.length - 1) {
        _currentIndex++;
        widget.onChange(_weeks[_currentIndex]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWeek = _weeks[_currentIndex];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: _prevWeek,
          tooltip: 'Previous Week',
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.date_indexed_week
                  .tr(namedArgs: {'index': '$_currentIndex'}),
            ),
            Text(
              '${currentWeek.formatDate(currentWeek.start)} - ${currentWeek.formatDate(currentWeek.end)}',
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: _nextWeek,
          tooltip: 'Next Week',
        ),
      ],
    );
  }
}
