import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people.g.dart';

@JsonSerializable(checked: true)
// ignore: public_member_api_docs
final class People extends IBaseModel<People> with EquatableMixin {
  const People({
    this.id,
    this.name,
    this.email,
    this.imagePath,
  });

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

  final String? id;
  final String? name;
  final String? email;
  final String? imagePath;

  @override
  List<Object?> get props => [id, name, email, imagePath];

  @override
  People fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PeopleToJson(this);
}
