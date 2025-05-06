import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'chat_preview_model.g.dart';

@JsonSerializable(checked: true)
final class ChatPreviewModel extends IBaseModel<ChatPreviewModel>
    with EquatableMixin {
  ChatPreviewModel({
    this.chatPreviewId,
    this.chatRoomId,
    this.members,
    this.groupName,
    this.isGroup = false,
    this.groupImageUrl,
    this.lastMessageText,
    this.lastMessageTime,
  });

  factory ChatPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPreviewModelFromJson(json);

  final String? chatPreviewId;
  final String? chatRoomId;
  final List<String>? members;
  final bool isGroup;
  final String? groupName;
  final String? groupImageUrl;
  final String? lastMessageText;
  @TimestampNullableConverter()
  final DateTime? lastMessageTime;

  String? getOhterUserId({String? currentUserId}) {
    if (members.ext.isNotNullOrEmpty) {
      return members!.firstWhere(
        (element) => element != currentUserId,
      );
    }
    return null;
  }

  @override
  ChatPreviewModel fromJson(Map<String, dynamic> json) =>
      _$ChatPreviewModelFromJson(json);

  @override
  List<Object?> get props => [chatPreviewId, chatRoomId];

  @override
  Map<String, dynamic> toJson() => _$ChatPreviewModelToJson(this);
}
