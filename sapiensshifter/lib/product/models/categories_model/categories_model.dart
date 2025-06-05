// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_model.g.dart';

@JsonSerializable(checked: true)
final class CategoriesModel extends IBaseModel<CategoriesModel>
    with EquatableMixin {
  const CategoriesModel({this.id, this.name});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  final String? id;
  final String? name;

  @override
  CategoriesModel fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);

  @override
  List<Object?> get props => [id, name];
}
