import 'package:flutter/foundation.dart';

@immutable
sealed class WorkingStatus {
  const WorkingStatus();
  T map<T>({
    required T Function(Working working) onWorking,
    required T Function(OffDay offDay) onOffDay,
    required T Function(Unassigned unassigned) onUnassigned,
  }) {
    // 'this' anahtar kelimesi o anki nesneyi temsil eder
    // (bir Working, OffDay, veya Unassigned nesnesi).
    // Dart 3 pattern matching gücü burada devreye giriyor.
    switch (this) {
      case final Working working:
        return onWorking(working);
      case final OffDay offDay:
        return onOffDay(offDay);
      case final Unassigned unassigned:
        return onUnassigned(unassigned);
    }
  }
}

final class Working extends WorkingStatus {
  const Working({this.branchName, this.branchId});
  final String? branchId;
  final String? branchName;
}

final class OffDay extends WorkingStatus {
  const OffDay({this.reason});
  final String? reason;
}

final class Unassigned extends WorkingStatus {
  const Unassigned({this.reason});
  final String? reason;
}
