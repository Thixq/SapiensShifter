import 'package:sapiensshifter/product/models/chats_model/chat_meta_data.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_room_models/chat_info.dart';

class ChatWithModel {
  ChatWithModel({this.chatInfo, this.chatMetadata});

  final ChatInfo? chatInfo;
  final ChatMetadata? chatMetadata;
}
