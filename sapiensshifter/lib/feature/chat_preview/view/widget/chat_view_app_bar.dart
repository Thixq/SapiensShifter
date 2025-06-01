part of '../chat_preview_view.dart';

class ChatViewAppBar extends StatelessWidget {
  const ChatViewAppBar({
    required TextEditingController searchController,
    required this.menuOnPressed,
    required this.newChatOnPressed,
    required this.searchOnChanged,
    required this.searchOnSubmitted,
    required this.menuGlobalKey,
    super.key,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final VoidCallback menuOnPressed;
  final VoidCallback newChatOnPressed;
  final ValueChanged<String> searchOnChanged;
  final ValueChanged<String> searchOnSubmitted;
  final GlobalKey menuGlobalKey;

  double get _kSearchBarHeight =>
      kMinInteractiveDimensionCupertino; // Genellikle 44.0

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: CupertinoTheme.of(context)
          .scaffoldBackgroundColor
          .withValues(alpha: .7),
      largeTitle: Text(LocaleKeys.page_chat_preview_chat.tr()),
      leading: _buildLeading(),
      trailing: _buildTrailing(),
      bottom: _buildSearchBar(context),
      stretch: true,
    );
  }

  CupertinoButton _buildLeading() {
    return CupertinoButton(
      key: menuGlobalKey,
      padding: EdgeInsets.zero,
      onPressed: menuOnPressed,
      child: const Icon(CupertinoIcons.ellipsis, size: 28),
    );
  }

  CupertinoButton _buildTrailing() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: newChatOnPressed,
      child: const Icon(CupertinoIcons.pencil_outline),
    );
  }

  PreferredSize _buildSearchBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(_kSearchBarHeight + (context.sized.lowValue * 2)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.sized.normalValue,
          vertical: context.sized.lowValue,
        ),
        child: CupertinoSearchTextField(
          controller: _searchController,
          placeholder: 'Ara',
          onChanged: searchOnChanged,
          onSubmitted: searchOnSubmitted,
        ),
      ),
    );
  }
}
