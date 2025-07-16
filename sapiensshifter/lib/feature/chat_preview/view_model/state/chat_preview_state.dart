// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sapiensshifter/product/models/chats_model/chat_meta_data.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';

final class ChatPreviewState extends Equatable {
  const ChatPreviewState({
    this.allUsers = const [],
    this.chats = const [],
    this.searchedChats = const [],
  });

  final List<UserPreviewModel> allUsers;
  final List<ChatMetadata> chats;
  final List<ChatMetadata> searchedChats;

  ChatPreviewState copyWith({
    List<UserPreviewModel>? allUsers,
    List<ChatMetadata>? chats,
    List<ChatMetadata>? searchedChats,
  }) {
    return ChatPreviewState(
      allUsers: allUsers ?? this.allUsers,
      chats: chats ?? this.chats,
      searchedChats: searchedChats ?? this.searchedChats,
    );
  }

  factory ChatPreviewState.initial() {
    return const ChatPreviewState();
  }

  @override
  List<Object?> get props => [chats, allUsers, searchedChats];
}
