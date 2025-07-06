part of '../view/settings_view.dart';

mixin SettingsViewMixin on BaseState<SettingsView> {
  late final SettingsViewModel _settingsViewModel;
  SettingsViewModel get viewModel => _settingsViewModel;

  late final GlobalKey imagePickerKey;
  late final ImagePickerService imagePickerService;

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
          onTap: () {
            context.router.pushPath(PagePathConstant.shiftAdd);
          },
          roles: [UserRole.admin, UserRole.manager],
        ),
      ];
  final filteredList = <BasicRoleTileModel>[];

  @override
  void dispose() {
    super.dispose();
  }
}
