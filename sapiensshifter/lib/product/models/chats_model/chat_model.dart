import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'chat_model.g.dart';

@JsonSerializable(checked: true)
final class ChatModel extends IBaseModel<ChatModel> with EquatableMixin {
  ChatModel({
    super.id,
    this.members,
    this.groupName,
    this.isGroup = false,
    this.groupImageUrl,
    this.lastMessageText,
    this.lastMessageTime,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  factory ChatModel.newChat({
    required List<String> members,
    String? groupName,
    String? groupImageUrl,
    bool isGroup = false,
  }) {
    final generatedChatId = _idGenerator(members);
    return ChatModel(
      id: generatedChatId,
      members: members,
      isGroup: isGroup,
      groupName: groupName,
      groupImageUrl: groupImageUrl,
    );
  }

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
  ChatModel fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

  @override
  List<Object?> get props => [id];

  @override
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  static String _idGenerator(List<String> members) {
    members.sort();
    final generatedChatId = StringBuffer()..writeAll(members);
    return generatedChatId.toString();
  }
}
