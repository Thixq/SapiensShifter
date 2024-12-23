import 'package:sapiensshifter/product/utils/enums/shift_status_enum.dart';

final class ShiftDay {
  ShiftDay({
    this.branch,
    this.shiftStatus,
    this.time,
  });

  final String? branch;
  final ShiftStatusEnum? shiftStatus;
  final DateTime? time;
}
