import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/settings/mixin/settings_view_mixin.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/basic_list_tile.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/basic_list_tile_builder.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/model/basic_list_tile_model.dart';
import 'package:sapiensshifter/product/models/user/sapiens_user/sapiens_user.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

part 'widget/profile_widget.dart';

@RoutePage()
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseState<SettingsView>
    with SettingsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.sized.normalValue),
          child: Column(
            children: [
              ProfileWidget(
                key: imagePickerKey,
                user: viewModel.getUser,
                onImagePicked: onImagePicked,
              ),
              context.sized.emptySizedHeightBoxNormal,
              Expanded(
                child: BasicListTileBuilder(
                  listTiles: filteredList,
                ),
              ),
              _buildSignOut(context),
            ],
          ),
        ),
      ),
    );
  }

  BasicListTile _buildSignOut(BuildContext context) {
    return BasicListTile(
      model: BasicListTileModel(
        icon: Icons.logout,
        title: LocaleKeys.page_settings_sign_out.tr(),
        onTap: () async {
          await viewModel.signOut(context);
        },
      ),
    );
  }
}
