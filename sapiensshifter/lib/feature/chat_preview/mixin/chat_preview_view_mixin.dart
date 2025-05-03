import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_preview/view/chat_preview_view.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/chat_preview_view_model.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/context_menu.dart';

mixin ChatPreviewViewMixin on BaseState<ChatPreviewView> {
  late final ChatPreviewViewModel _previewViewModel;

  ChatPreviewViewModel get viewModel => _previewViewModel;
  late GlobalKey menuGlobalKey;

  @override
  void initState() {
    _previewViewModel = ChatPreviewViewModel(
      ChatPreviewState.initial(),
      networkManager: ProductConfigureItems.networkManager,
      profile: ProductConfigureItems.profile,
    );
    _previewViewModel.getStreamPrewViewList();
    menuGlobalKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _previewViewModel.dispose();
    super.dispose();
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
