import 'package:equatable/equatable.dart';
import 'package:sapiensshifter/feature/chat_room/model/chat_info.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';

sealed class ChatWithState extends Equatable {
  const ChatWithState({this.chatInfo});
  final ChatInfo? chatInfo;

  @override
  List<Object?> get props => [chatInfo];
}

// Bu state'lerde mesaja dair bir bilgi yok, çünkü olmamalı.
class ChatLoading extends ChatWithState {}

class ChatError extends ChatWithState {
  const ChatError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

// Diğer state'leriniz...
class ChatWithIdState extends ChatWithState {
  const ChatWithIdState({super.chatInfo});
}

class ChatWithModelState extends ChatWithState {
  const ChatWithModelState({this.chatModel, super.chatInfo});
  final ChatModel? chatModel;
  @override
  List<Object?> get props => [...super.props, chatModel];
}

class ChatLoaded extends ChatWithState {
  const ChatLoaded({
    this.messages,
    super.chatInfo,
  });

  final List<MessageModel>? messages;

  @override
  List<Object?> get props => [
        ...super.props,
        messages,
      ];

  ChatLoaded copyWith({
    ChatInfo? chatInfo,
    List<MessageModel>? messages,
  }) {
    return ChatLoaded(
      chatInfo: chatInfo ?? this.chatInfo,
      messages: messages ?? this.messages,
    );
  }
}
