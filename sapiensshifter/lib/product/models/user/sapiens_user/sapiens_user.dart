// ignore_for_file: avoid_redundant_argument_values

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/enums/user_role.dart';

part 'sapiens_user.g.dart';

@JsonSerializable(checked: true)
// ignore: public_member_api_docs
final class SapiensUser extends IBaseModel<SapiensUser> with EquatableMixin {
  const SapiensUser({
    super.id,
    this.name,
    this.email,
    this.role,
    this.photoUrl,
    this.toDayBranch,
    this.userPreviewId,
    this.chatPreviewIdList,
  });

  factory SapiensUser.create({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? userPreviewId,
  }) {
    return SapiensUser(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      userPreviewId: userPreviewId,
      role: UserRole.user,
      chatPreviewIdList: [],
      toDayBranch: null,
    );
  }

  factory SapiensUser.fromJson(Map<String, dynamic> json) =>
      _$SapiensUserFromJson(json);

  final String? name;
  final String? email;
  final String? photoUrl;
  final String? toDayBranch;
  final String? userPreviewId;
  final List<String>? chatPreviewIdList;
  final UserRole? role;

  @override
  List<Object?> get props => [id, name, email];

  @override
  SapiensUser fromJson(Map<String, dynamic> json) =>
      _$SapiensUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SapiensUserToJson(this);
}
