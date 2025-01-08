import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/component/message_info_list_tile.dart';
import 'package:sapiensshifter/product/models/people.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/ui/separator_column.dart';

class NewChatBottomSheet extends StatefulWidget {
  const NewChatBottomSheet({this.peopleList, super.key});

  final List<People>? peopleList;

  static Future<People?> show(
    BuildContext context, {
    List<People>? peopleList,
  }) =>
      showModalBottomSheet<People?>(
        backgroundColor: Colors.transparent,
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

  final String _nullOrEmptyList = 'Boş Liste';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .85, // Tam ekran başlatır
      minChildSize: 0.4, // Minimum yüksekliği
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: context.general.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: context.border.normalRadius,
              topRight: context.border.normalRadius,
            ),
          ),
          child: Padding(
            padding: context.padding.low,
            child: SeparatorColumn(
              separator: context.sized.emptySizedHeightBoxLow,
              children: [
                _buildNotch(context),
                _buildSearchBar(context),
                _buildPeopleList(),
              ],
            ),
          ),
        );
      },
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

  List<People> _filteredPeopleList(String query) {
    var filteredItems = <People>[];
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

  Expanded _buildPeopleListTile(List<People> filteredItems) {
    return Expanded(
      child: ListView.separated(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) => MessageInfoListTile(
          onPressed: () {
            context.route.pop(filteredItems[index]);
          },
          imageUrl: filteredItems[index].imagePath,
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
