part of '../chat_room_view_model.dart';

mixin _ChatRoomUtils on BaseCubit<ChatWithState> {
  void _buildMessageWrites<T>({
    required T writer, // Bu, batch veya transaction nesnesi olabilir.
    required void Function({
      required T writer,
      required String path,
      required IBaseModel<MessageModel> item,
    }) createAction,
    required void Function({
      required T writer,
      required String path,
      required Map<String, dynamic> data,
    }) updateAction,
    required String chatId,
    required String text,
    required String senderId,
  }) {
    final messageId = const UuidV7().generate();
    final chatPath = '${QueryPathConstant.chatPreviewColPath}/$chatId';
    final messagePath =
        '${QueryPathConstant.messagesColPath(chatId)}/$messageId';
    final message = MessageModel(
      id: messageId,
      senderId: senderId,
      text: text,
      timeStamp: DateTime.now().toLocal(),
    );

    createAction(writer: writer, path: messagePath, item: message);

    updateAction(
      writer: writer,
      path: chatPath,
      data: {
        'lastMessageText': text,
        'lastMessageTime': DateTime.now().toLocal(),
      },
    );
  }
}
