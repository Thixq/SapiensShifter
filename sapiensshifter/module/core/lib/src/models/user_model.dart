// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

final class UserModel extends IBaseModel<UserModel> {
  UserModel({
    required this.id,
    required this.photoUrl,
    required this.displayName,
    required this.email,
  });

  final String? id;
  final String? photoUrl;
  final String? displayName;
  final String? email;

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        photoUrl: json['photoUrl'],
        displayName: json['displayName'],
        email: json['email']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'email': email,
      'displayName': displayName
    };
  }

  UserModel copyWith({
    String? id,
    String? photoUrl,
    String? displayName,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }
}
