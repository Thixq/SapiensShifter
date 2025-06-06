import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preview_model.g.dart';

@JsonSerializable(checked: true)
final class UserPreviewModel extends IBaseModel<UserPreviewModel>
    with EquatableMixin {
  UserPreviewModel({this.userId, super.id, this.name, this.photoUrl});

  factory UserPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);

  final String? userId;
  final String? name;
  final String? photoUrl;

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        photoUrl,
      ];

  @override
  UserPreviewModel fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserPreviewModelToJson(this);
}
