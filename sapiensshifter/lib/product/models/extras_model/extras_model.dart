import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/json_converters/double_key_map_converter.dart';

part 'extras_model.g.dart';

@JsonSerializable(checked: true)
final class ExtrasModel extends IBaseModel<ExtrasModel> with EquatableMixin {
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

  Map<String, double>? get allOptionsMapEntry {
    if (optionsList == null || optionsList!.isEmpty) return null;

    return {
      for (final entry in optionsList!.entries)
        for (final item in entry.value) item: entry.key,
    };
  }
}
