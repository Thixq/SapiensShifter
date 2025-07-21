// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

final class AuthModel extends IBaseModel<AuthModel> {
  AuthModel({
    required super.id,
    required this.photoUrl,
    required this.displayName,
    required this.email,
  });

  final String? photoUrl;
  final String? displayName;
  final String? email;

  @override
  AuthModel fromJson(Map<String, dynamic> json) {
    return AuthModel(
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

  AuthModel copyWith({
    String? id,
    String? photoUrl,
    String? displayName,
    String? email,
  }) {
    return AuthModel(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }
}
