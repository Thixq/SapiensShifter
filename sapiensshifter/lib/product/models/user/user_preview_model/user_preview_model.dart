import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preview_model.g.dart';

@JsonSerializable(checked: true)
final class UserPreviewModel extends IBaseModel<UserPreviewModel>
    with EquatableMixin {
  UserPreviewModel({this.userId, this.userPreviewId, this.name, this.imageUrl});

  factory UserPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);

  final String? userPreviewId;
  final String? userId;
  final String? name;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        userPreviewId,
        userId,
        name,
        imageUrl,
      ];

  @override
  UserPreviewModel fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserPreviewModelToJson(this);
}
