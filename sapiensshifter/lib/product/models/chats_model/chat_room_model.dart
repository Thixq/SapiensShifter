import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class ChatRoomModel extends IBaseModel<ChatRoomModel>
    with EquatableMixin {
  ChatRoomModel(
    this.chatRoomId,
    this.members,
    this.groupName,
    this.groupImageUrl,
  );

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  final String? chatRoomId;
  final List<UserPreviewModel>? members;
  final String? groupName;
  final String? groupImageUrl;

  @override
  ChatRoomModel fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  @override
  List<Object?> get props => [
        chatRoomId,
      ];

  @override
  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
