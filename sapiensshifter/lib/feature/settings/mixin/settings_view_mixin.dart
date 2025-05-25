import 'package:flutter/material.dart' show Icons;
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/settings/view/settings_view.dart';
import 'package:sapiensshifter/feature/settings/view_model/settings_view_model.dart';
import 'package:sapiensshifter/product/component/basic_list_tile/model/basic_list_tile_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

mixin SettingsViewMixin on BaseState<SettingsView> {
  late final SettingsViewModel _settingsViewModel;
  SettingsViewModel get viewModel => _settingsViewModel;

  List<BasicListTileModel> get actionsList => [
        BasicListTileModel(
          icon: Icons.list_alt,
          title: LocaleKeys.page_settings_actions_text_history_order.tr(),
          onTap: () {},
        ),
        BasicListTileModel(
          icon: Icons.coffee,
          title: LocaleKeys.page_settings_actions_text_new_product.tr(),
          onTap: () {},
        ),
        BasicListTileModel(
          icon: Icons.currency_lira,
          title: LocaleKeys.page_settings_actions_text_price_edit.tr(),
          onTap: () {},
        ),
        BasicListTileModel(
          icon: Icons.add,
          title: LocaleKeys.page_settings_actions_text_shift_add.tr(),
          onTap: () {},
        ),
      ];

  @override
  void initState() {
    _settingsViewModel =
        SettingsViewModel(profile: ProductConfigureItems.profile);
    super.initState();
  }
}
