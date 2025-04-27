import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable(checked: true)
final class MemberModel extends IBaseModel<MemberModel> with EquatableMixin {
  MemberModel(this.id, this.name, this.imageUrl);

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  final String? id;
  final String? name;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
      ];

  @override
  MemberModel fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
