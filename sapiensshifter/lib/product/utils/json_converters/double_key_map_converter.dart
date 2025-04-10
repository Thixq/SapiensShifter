import 'package:json_annotation/json_annotation.dart';

class DoubleKeyMapConverter
    implements
        JsonConverter<Map<double, List<String>>?, Map<String, dynamic>?> {
  const DoubleKeyMapConverter();

  @override
  Map<double, List<String>>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return json.map((key, value) {
      final parsedKey = double.tryParse(key);
      if (parsedKey == null) {
        throw FormatException('Key "$key" is not a valid double.');
      }
      final parsedValue =
          (value as List).map((item) => item.toString()).toList();
      return MapEntry(parsedKey, parsedValue);
    });
  }

  @override
  Map<String, dynamic>? toJson(Map<double, List<String>>? map) {
    if (map == null) return null;

    return map.map((key, value) => MapEntry(key.toString(), value));
  }
}
