import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapiensshifter/core/state/base/base_state.dart';
import 'package:sapiensshifter/feature/new_product_add/mixin/new_product_view_mixin.dart';
import 'package:sapiensshifter/feature/new_product_add/view_model/new_product_view_model.dart';
import 'package:sapiensshifter/feature/new_product_add/view_model/state/new_product_state.dart';
import 'package:sapiensshifter/product/component/image_picker.dart';
import 'package:sapiensshifter/product/constant/assets_path_constant.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/enums/localization/localization_path_enum.dart';

import 'package:sapiensshifter/product/utils/enums/localization/product_validate_localization_enum.dart';
import 'package:sapiensshifter/product/utils/enums/picker_source.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';
import 'package:sapiensshifter/product/utils/extensions/map_extension.dart';
import 'package:sapiensshifter/product/utils/input_formatters/decimal_input_formatter.dart';
import 'package:sapiensshifter/product/utils/static_func/image_normalized.dart';
import 'package:sapiensshifter/product/utils/validator/product_validator.dart';

part 'widget/product_image.dart';
part 'widget/product_form.dart';

@RoutePage()
class NewProductAddView extends StatefulWidget {
  const NewProductAddView({super.key});

  @override
  State<NewProductAddView> createState() => _NewProductAddViewState();
}

class _NewProductAddViewState extends BaseState<NewProductAddView>
    with NewProductViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.page_new_product_add_add_product.tr()),
        ),
        body: BlocBuilder<NewProductViewModel, NewProductState>(
          builder: (context, state) => ProductForm(
            product: state.product,
            formKey: formKey,
            imageKey: productImageKey,
            confirmProduct: (product) async {
              await confirmProduct(product: product);
            },
            extras: state.extras,
            categorys: state.category,
          ),
        ),
      ),
    );
  }
}
