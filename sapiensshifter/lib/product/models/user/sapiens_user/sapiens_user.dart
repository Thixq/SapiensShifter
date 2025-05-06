import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sapiens_user.g.dart';

@JsonSerializable(checked: true)
// ignore: public_member_api_docs
final class SapiensUser extends IBaseModel<SapiensUser> with EquatableMixin {
  const SapiensUser({
    this.id,
    this.name,
    this.email,
    this.imagePath,
    this.toDayBranch,
    this.userPreviewId,
    this.chatPreviewIdList,
  });

  factory SapiensUser.fromJson(Map<String, dynamic> json) =>
      _$SapiensUserFromJson(json);

  final String? id;
  final String? name;
  final String? email;
  final String? imagePath;
  final String? toDayBranch;
  final String? userPreviewId;
  final List<String>? chatPreviewIdList;

  @override
  List<Object?> get props => [id, name, email];

  @override
  SapiensUser fromJson(Map<String, dynamic> json) =>
      _$SapiensUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SapiensUserToJson(this);
}
