import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// For non-nullable DateTime <-> Timestamp conversion
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate().toLocal();
  }

  @override
  Timestamp toJson(DateTime date) {
    return Timestamp.fromDate(date);
  }
}

// For nullable DateTime? <-> Timestamp? conversion
// If your field in Firestore may be null, or if your Flutter model
// If the DateTime field can be null, use this
//(for example: DateTime? updatedAt)
class TimestampNullableConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampNullableConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate().toLocal();
  }

  @override
  Timestamp? toJson(DateTime? date) {
    return date == null ? null : Timestamp.fromDate(date);
  }
}
