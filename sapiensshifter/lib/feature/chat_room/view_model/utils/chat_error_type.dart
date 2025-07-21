import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

enum ChatErrorType {
  infoUnavailable(
    LocaleKeys.page_chat_room_error_chat_state_error_chat_info_unavailable,
  ),
  invalidId(LocaleKeys.page_chat_room_error_chat_state_error_chat_invalid_id),
  loadFailed(
    LocaleKeys.page_chat_room_error_chat_state_error_chat_load_failed,
  ),
  sendFailed(
    LocaleKeys.page_chat_room_error_chat_state_error_chat_send_failed,
  ),
  missingInfoForSend(
    LocaleKeys.page_chat_room_error_chat_state_error_chat_missing_info,
  );

  const ChatErrorType(this.message);
  final String message;
}
