// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:core/core.dart';

final class AuthModel extends IBaseModel<AuthModel> {
  AuthModel({
    super.id,
    this.photoUrl,
    this.displayName,
    this.email,
    this.customClaim,
  });

  final String? photoUrl;
  final String? displayName;
  final String? email;
  final Map<String, dynamic>? customClaim;

  @override
  AuthModel fromJson(Map<String, dynamic> json) {
    return AuthModel(
        id: json['id'],
        photoUrl: json['photoUrl'],
        displayName: json['displayName'],
        email: json['email'],
        customClaim: json['customClaim']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'email': email,
      'displayName': displayName,
      'customClaim': customClaim
    };
  }

  AuthModel copyWith({
    String? photoUrl,
    String? displayName,
    String? email,
    Map<String, dynamic>? customClaim,
  }) {
    return AuthModel(
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      customClaim: customClaim ?? this.customClaim,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photoUrl': photoUrl,
      'displayName': displayName,
      'email': email,
      'customClaim': customClaim,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      customClaim: map['customClaim'] != null
          ? Map<String, dynamic>.from(
              (map['customClaim'] as Map<String, dynamic>))
          : null,
    );
  }

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
