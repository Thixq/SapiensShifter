// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/src/interfaces/network_query_interface/network_query_utils/cursor_condition_enum.dart';

final class CursorCondition {
  final CursorType type;

  final List<Object?> fieldValues;
  CursorCondition({
    required this.type,
    required this.fieldValues,
  });
}
