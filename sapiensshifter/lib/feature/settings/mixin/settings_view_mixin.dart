import 'package:flutter/material.dart' show Icons, PopupMenuItem;
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/settings/view/settings_view.dart';
import 'package:sapiensshifter/feature/settings/view_model/settings_view_model.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/model/extend/basic_role_tile_model.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/context_menu.dart';
import 'package:sapiensshifter/product/utils/enums/user_role.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

mixin SettingsViewMixin on BaseState<SettingsView> {
  late final SettingsViewModel _settingsViewModel;
  SettingsViewModel get viewModel => _settingsViewModel;

  final GlobalKey imagePickerKey = GlobalKey();

  void onImagePicked() {
    ContextMenu.show<XFile>(
      key: imagePickerKey,
      items: [
        PopupMenuItem(
          child: Text(LocaleKeys.page_settings_image_picker_camera.tr()),
          onTap: () async {},
        ),
        PopupMenuItem(
          child: Text(LocaleKeys.page_settings_image_picker_gallery.tr()),
          onTap: () async {},
        ),
      ],
    );
  }

  List<BasicRoleTileModel> get actionsList => [
        BasicRoleTileModel(
          icon: Icons.list_alt,
          title: LocaleKeys.page_settings_actions_text_history_order.tr(),
          onTap: () {},
          roles: [UserRole.user, UserRole.admin, UserRole.manager],
        ),
        BasicRoleTileModel(
          icon: Icons.coffee,
          title: LocaleKeys.page_settings_actions_text_new_product.tr(),
          onTap: () {},
          roles: [UserRole.admin, UserRole.manager],
        ),
        BasicRoleTileModel(
          icon: Icons.currency_lira,
          title: LocaleKeys.page_settings_actions_text_price_edit.tr(),
          onTap: () {},
          roles: [UserRole.admin, UserRole.manager],
        ),
        BasicRoleTileModel(
          icon: Icons.add,
          title: LocaleKeys.page_settings_actions_text_shift_add.tr(),
          onTap: () {},
          roles: [UserRole.admin, UserRole.manager],
        ),
      ];
  final filteredList = <BasicRoleTileModel>[];

  @override
  void initState() {
    _settingsViewModel =
        SettingsViewModel(profile: ProductConfigureItems.profile);
    final userRole = viewModel.getUser?.role;
    if (userRole != null) {
      filteredList.addAll(
        actionsList.where((element) => element.isVisibleTo(userRole)),
      );
    }
    super.initState();
  }
}
