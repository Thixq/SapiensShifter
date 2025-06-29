import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/interface/interface_model/product_base_model_interface.dart';

part 'extras_model.g.dart';

@JsonSerializable(checked: true)
final class ExtrasModel extends Equatable
    implements ProductBaseModelInterface<ExtrasModel> {
  const ExtrasModel({
    this.id,
    this.name,
    this.optionsList,
  });

  factory ExtrasModel.fromJson(Map<String, dynamic> json) =>
      _$ExtrasModelFromJson(json);

  final String? id;
  final String? name;
  @DoubleKeyMapConverter()
  final Map<double, List<String>>? optionsList;

  @override
  List<Object?> get props => [id, name, optionsList];

  @override
  ExtrasModel fromJson(Map<String, dynamic> json) =>
      _$ExtrasModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExtrasModelToJson(this);

  Map<String, double>? allOptionsMapEntry() {
    final convertedMap = <String, double>{};
    if (optionsList == null || optionsList!.isEmpty) return null;

    for (final entries in optionsList!.entries) {
      for (final item in entries.value) {
        final key = entries.key;
        convertedMap.addEntries([MapEntry(item, key)]);
      }
    }
    return convertedMap;
  }
}

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
