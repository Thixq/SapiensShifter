// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

final class ChatInfo extends Equatable {
  const ChatInfo({this.chatName, this.chatImageUrl});

  final String? chatName;
  final String? chatImageUrl;

  ChatInfo copyWith({
    String? chatId,
    String? chatName,
    String? chatImageUrl,
  }) {
    return ChatInfo(
      chatName: chatName ?? this.chatName,
      chatImageUrl: chatImageUrl ?? this.chatImageUrl,
    );
  }

  @override
  List<Object?> get props => [chatName, chatImageUrl];
}
