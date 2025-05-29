import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/message_info_list_tile.dart';
import 'package:sapiensshifter/product/models/user/user_preview_model/user_preview_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/ui/separator_list_widget.dart';

class NewChatBottomSheet extends StatefulWidget {
  const NewChatBottomSheet({this.peopleList, super.key});

  final List<UserPreviewModel>? peopleList;

  static Future<UserPreviewModel?> show(
    BuildContext context, {
    List<UserPreviewModel>? peopleList,
  }) =>
      showModalBottomSheet<UserPreviewModel?>(
        isScrollControlled: true,
        context: context,
        builder: (context) => NewChatBottomSheet(
          peopleList: peopleList,
        ),
      );

  @override
  State<NewChatBottomSheet> createState() => _NewChatBottomSheetState();
}

class _NewChatBottomSheetState extends State<NewChatBottomSheet> {
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  String get _nullOrEmptyList => LocaleKeys.empty_items.tr();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: context.general.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: context.border.normalRadius,
          topRight: context.border.normalRadius,
        ),
      ),
      child: Padding(
        padding: context.padding.low,
        child: SeparatorListWidget(
          separator: context.sized.emptySizedHeightBoxLow,
          children: [
            _buildNotch(context),
            _buildSearchBar(context),
            _buildPeopleList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleList() {
    return widget.peopleList.ext.isNotNullOrEmpty
        ? ValueListenableBuilder(
            valueListenable: _searchQuery,
            builder: (context, query, child) {
              final filteredItems = _filteredPeopleList(query);
              return _buildPeopleListTile(filteredItems);
            },
          )
        : Center(
            child: Text(_nullOrEmptyList),
          );
  }

  List<UserPreviewModel> _filteredPeopleList(String query) {
    var filteredItems = <UserPreviewModel>[];
    if (widget.peopleList.ext.isNotNullOrEmpty) {
      filteredItems = widget.peopleList!.where(
        (item) {
          if (item.name.ext.isNotNullOrNoEmpty) {
            return item.name!.toLowerCase().contains(query.toLowerCase());
          }
          return true;
        },
      ).toList();
    }
    return filteredItems;
  }

  Expanded _buildPeopleListTile(List<UserPreviewModel> filteredItems) {
    return Expanded(
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: filteredItems.length,
        itemBuilder: (context, index) => MessageInfoListTile(
          onPressed: () {
            context.route.pop(filteredItems[index]);
          },
          imageUrl: filteredItems[index].photoUrl,
          title: filteredItems[index].name,
        ),
        separatorBuilder: (context, index) =>
            context.sized.emptySizedHeightBoxLow,
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        _searchQuery.value = value;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: context.border.normalBorderRadius,
        ),
      ),
    );
  }

  Container _buildNotch(BuildContext context) {
    return Container(
      height: 8,
      width: 50,
      margin: context.padding.verticalLow,
      decoration: BoxDecoration(
        color: context.general.appTheme.hintColor,
        borderRadius: context.border.lowBorderRadius,
      ),
    );
  }
}
