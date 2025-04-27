import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/models/chats_model/member_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class ChatRoomModel extends IBaseModel<ChatRoomModel>
    with EquatableMixin {
  ChatRoomModel(this.id, this.members, this.name, this.imageUrl, this.messages);

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  final String? id;
  final List<MemberModel>? members;
  final String? name;
  final String? imageUrl;
  final List<MessageModel>? messages;

  @override
  ChatRoomModel fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        members,
        name,
      ];

  @override
  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
