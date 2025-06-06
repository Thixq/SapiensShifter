import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' show Icons, PopupMenuItem;
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/settings/view/settings_view.dart';
import 'package:sapiensshifter/feature/settings/view_model/settings_view_model.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/model/extend/basic_role_tile_model.dart';
import 'package:sapiensshifter/product/component/image_picker.dart';
import 'package:sapiensshifter/product/constant/page_path_constant.dart';
import 'package:sapiensshifter/product/utils/dialogs_and_bottom_sheet/context_menu.dart';
import 'package:sapiensshifter/product/utils/enums/picker_source.dart';
import 'package:sapiensshifter/product/utils/enums/user_role.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/static_func/image_normalized.dart';

mixin SettingsViewMixin on BaseState<SettingsView> {
  late final SettingsViewModel _settingsViewModel;
  SettingsViewModel get viewModel => _settingsViewModel;

  late final GlobalKey imagePickerKey;
  late final ImagePickerService imagePickerService;

  void onImagePicked() {
    ContextMenu.show<XFile>(
      key: imagePickerKey,
      items: [
        PopupMenuItem(
          child: Text(LocaleKeys.page_settings_image_picker_camera.tr()),
          onTap: () async {
            final image = await imagePickerService.pick(PickerSource.camera);
            if (image != null) {
              await _updatePhoto(image);
              if (mounted) {
                setState(() {});
              }
            }
          },
        ),
        PopupMenuItem(
          child: Text(LocaleKeys.page_settings_image_picker_gallery.tr()),
          onTap: () async {
            final image = await imagePickerService.pick(PickerSource.gallery);
            if (image != null) {
              await _updatePhoto(image);
              if (mounted) {
                setState(() {});
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> _updatePhoto(XFile image) async {
    final photoBytes = await image.readAsBytes();
    final mimeType = lookupMimeType(image.name, headerBytes: photoBytes);
    final normalizedByte =
        ImageNormalized.imageCleanEXIFData(photoBytes: photoBytes);
    await _settingsViewModel.updatePhoto(
      photoBytes: normalizedByte,
      mimeType: mimeType,
    );
  }

  List<BasicRoleTileModel> get actionsList => [
        BasicRoleTileModel(
          icon: Icons.list_alt,
          title: LocaleKeys.page_settings_actions_text_history_order.tr(),
          onTap: () {
            context.router.pushPath(PagePathConstant.orderHistory);
          },
          roles: [UserRole.user, UserRole.admin, UserRole.manager],
        ),
        BasicRoleTileModel(
          icon: Icons.coffee,
          title: LocaleKeys.page_settings_actions_text_new_product.tr(),
          onTap: () {
            context.router.pushPath(PagePathConstant.newProductAdd);
          },
          roles: [UserRole.admin, UserRole.manager],
        ),
        BasicRoleTileModel(
          icon: Icons.currency_lira,
          title: LocaleKeys.page_settings_actions_text_price_edit.tr(),
          onTap: () {
            context.router.pushPath(PagePathConstant.productPriceEdit);
          },
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
    imagePickerKey = GlobalKey();
    imagePickerService = ImagePickerService();
    final userRole = viewModel.getUser?.role;
    if (userRole != null) {
      filteredList.addAll(
        actionsList.where((element) => element.isVisibleTo(userRole)),
      );
    }
    super.initState();
  }
}
