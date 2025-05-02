import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'chat_preview_model.g.dart';

@JsonSerializable(checked: true)
final class ChatPreviewModel extends IBaseModel<ChatPreviewModel>
    with EquatableMixin {
  ChatPreviewModel({
    this.id,
    this.chatRoomId,
    this.chatName,
    this.isGroup,
    this.imageUrl,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPreviewModelFromJson(json);

  final String? id;
  final String? chatRoomId;
  final String? chatName;
  final bool? isGroup;
  final String? imageUrl;
  final String? lastMessage;
  @TimestampNullableConverter()
  final DateTime? lastMessageTime;

  @override
  ChatPreviewModel fromJson(Map<String, dynamic> json) =>
      _$ChatPreviewModelFromJson(json);

  @override
  List<Object?> get props => [id, chatRoomId];

  @override
  Map<String, dynamic> toJson() => _$ChatPreviewModelToJson(this);
}
