// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/models/chats_model/message.dart';

part 'chat_meta_data.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
final class ChatMetadata extends IBaseModel<ChatMetadata> with EquatableMixin {
  ChatMetadata({
    super.id,
    this.groupName,
    this.isGroup = false,
    this.groupImageUrl,
    this.lastMessage,
    this.members,
  });
  factory ChatMetadata.fromJson(Map<String, dynamic> json) =>
      _$ChatMetadataFromJson(json);

  factory ChatMetadata.oneToOne({
    required Set<String?> members,
  }) {
    final generatedChatId = _idGenerator(members);

    return ChatMetadata(
      id: generatedChatId,
      members: members,
    );
  }

  factory ChatMetadata.newGroup({
    required Set<String?> groupList,
    required String groupName,
    required String groupImageUrl,
  }) {
    final generatedChatId = _idGenerator(groupList);

    return ChatMetadata(
      id: generatedChatId,
      members: groupList,
      groupImageUrl: groupImageUrl,
      groupName: groupName,
    );
  }

  final bool isGroup;
  final String? groupName;
  final String? groupImageUrl;
  final Set<String?>? members;
  final Message? lastMessage;

  @override
  ChatMetadata fromJson(Map<String, dynamic> json) =>
      _$ChatMetadataFromJson(json);

  @override
  List<Object?> get props => [
        id,
        members,
        groupName,
        groupImageUrl,
        isGroup,
      ];

  @override
  Map<String, dynamic> toJson() => _$ChatMetadataToJson(this);

  String? getOhterUserId(String? currentUser) {
    if (!isGroup) {
      return members?.firstWhere(
        (element) => element != currentUser,
      );
    }
    return null;
  }

  static String? _idGenerator(Set<String?> members) {
    final listMember = members.toList()..sort();
    if (listMember.length == 2) {
      final generatedChatId = StringBuffer()..writeAll(listMember);
      return generatedChatId.toString();
    }
    return '${members.first}#${members.length}#${members.last}';
  }

  ChatMetadata copyWith({
    bool? isGroup,
    String? groupName,
    String? groupImageUrl,
    Set<String?>? members,
    Message? lastMessage,
  }) {
    return ChatMetadata(
      isGroup: isGroup ?? this.isGroup,
      groupName: groupName ?? this.groupName,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
