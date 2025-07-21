// ignore_for_file: one_member_abstracts

import 'package:sapiensshifter/product/utils/enums/picker_source.dart';

abstract class IPicker<R> {
  Future<R?> pick(PickerSource source);
}
