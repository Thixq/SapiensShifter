import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/chat_preview/view/chat_preview_view.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/chat_preview_view_model.dart';
import 'package:sapiensshifter/feature/chat_preview/view_model/state/chat_preview_state.dart';

mixin ChatPreviewViewMixin on BaseState<ChatPreviewView> {
  late final ChatPreviewViewModel _previewViewModel;

  ChatPreviewViewModel get viewModel => _previewViewModel;

  @override
  void initState() {
    _previewViewModel = ChatPreviewViewModel(
      ChatPreviewState.initial(),
      iNetworkManager: ProductConfigureItems.networkManager,
      profile: ProductConfigureItems.profile,
    );
    _previewViewModel.getPreviewList();
    super.initState();
  }
}
