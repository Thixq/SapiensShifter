import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_preview/view/chat_preview_view.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/chat_preview_view_model.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';
import 'package:sapiensshifter/product/models/chats_model/chat_model.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/context_menu.dart';

mixin ChatPreviewViewMixin on BaseState<ChatPreviewView> {
  late final ChatPreviewViewModel _previewViewModel;

  final _profile = ProductConfigureItems.profile;
  String? get getProfileId => _profile.user?.userPreviewId;

  ChatPreviewViewModel get viewModel => _previewViewModel;
  late GlobalKey menuGlobalKey;

  @override
  void initState() {
    _previewViewModel = ChatPreviewViewModel(
      ChatPreviewState.initial(),
      networkManager: ProductConfigureItems.networkManager,
      profile: _profile,
    );
    _previewViewModel.initial();
    menuGlobalKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _previewViewModel.dispose();
    super.dispose();
  }

  ChatModel? newChat({required UserPreviewModel user}) {
    if (user.userPreviewId != null && getProfileId != null) {
      final usersPreviewIds = <String>[
        user.userPreviewId!,
        getProfileId!,
      ]..sort();
      final stringBuffer = StringBuffer()..writeAll(usersPreviewIds);
      final chat =
          ChatModel(chatId: stringBuffer.toString(), members: usersPreviewIds);
      return chat;
    }
    return null;
  }

  void menuOnPressed() {
    ContextMenu.show<int>(
      key: menuGlobalKey,
      items: [
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Karaköy'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 2,
          child: Text(
            'Kanyon',
          ),
        ),
      ],
    );
  }
}
