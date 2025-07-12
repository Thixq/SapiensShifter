// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sapiensshifter/feature/chat_room/model/chat_info.dart';
import 'package:sapiensshifter/feature/chat_room/view_model/utils/chat_error_type.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/chats_model/message_model.dart';

sealed class ChatWithState extends Equatable {
  final ChatInfo? chatInfo;
  const ChatWithState({this.chatInfo});

  @override
  List<Object?> get props => [];
}

// Bu state'lerde mesaja dair bir bilgi yok, çünkü olmamalı.
class ChatLoading extends ChatWithState {}

class ChatError extends ChatWithState {
  const ChatError(this.errorType); // Artık bir enum alıyor.
  final ChatErrorType errorType;

  @override
  List<Object?> get props => [errorType];
}

// Diğer state'leriniz...
class ChatWithIdState extends ChatWithState {
  const ChatWithIdState({this.chatId});

  final String? chatId;

  ChatWithIdState copyWith({
    String? chatId,
  }) {
    return ChatWithIdState(
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  List<Object?> get props => [chatId, ...super.props];
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
    this.chatId,
  });

  final List<MessageModel>? messages;
  final String? chatId;

  @override
  List<Object?> get props => [
        ...super.props,
        messages,
      ];

  ChatLoaded copyWith({
    List<MessageModel>? messages,
    ChatInfo? chatInfo,
    String? chatId,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      chatInfo: chatInfo ?? this.chatInfo,
      chatId: chatId ?? this.chatId,
    );
  }
}
