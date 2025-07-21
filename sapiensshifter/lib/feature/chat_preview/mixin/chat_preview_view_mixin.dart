part of '../view/chat_preview_view.dart';

mixin ChatPreviewViewMixin on BaseState<ChatPreviewView> {
  late final ChatPreviewViewModel _previewViewModel;

  final _profile = ProductConfigureItems.profile;
  String? get getUserId => _profile.user?.userPreviewId;

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

  ChatMetadata? newChat({required UserPreviewModel user}) {
    if (user.id != null && getUserId != null) {
      final usersPreviewIds = <String?>{
        user.id,
        getUserId,
      };
      final chat = ChatMetadata.oneToOne(
        members: usersPreviewIds,
      );
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
