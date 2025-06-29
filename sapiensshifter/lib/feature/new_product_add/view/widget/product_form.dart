// ignore_for_file: must_be_immutable

part of '../new_product_add_view.dart';

final class ProductForm extends StatelessWidget {
  ProductForm({
    required this.confirmProduct,
    required this.extras,
    required this.categorys,
    required this.formKey,
    required this.product,
    required this.imageKey,
    super.key,
  });

  final ValueChanged<ProductModel> confirmProduct;
  final List<ExtrasModel> extras;
  final List<CategoriesModel> categorys;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ProductImageState> imageKey;

  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: context.sized.normalValue,
          ),
          child: Form(
            key: formKey,
            child: SeparatorListWidget(
              separator: context.sized.emptySizedHeightBoxLow,
              children: [
                _buildImagePick(),
                _buildProductName(),
                _buildProductDesc(),
                _buildProductPrice(),
                _buildProductCategory(),
                _buildExtras(),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: SapiButton(
                    buttonText: LocaleKeys.confirm.tr(),
                    onPressed: () {
                      confirmProduct(product);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExtras() {
    return SapiCustomDropDown<String>.multiSelect(
      hintText: LocaleKeys.page_new_product_add_form_extra.tr(),
      items: extras
          .map(
            (extra) => SapiDropDownModel(
              displayName:
                  extra.name.sapiExt.textLocale(LocalizationPathEnum.options),
              value: extra.id,
            ),
          )
          .toList(),
      onListChanged: (select) =>
          product = product.copyWith(productOptions: select),
    );
  }

  Widget _buildProductCategory() {
    return SapiCustomDropDown<String>(
      hintText: LocaleKeys.page_new_product_add_form_category.tr(),
      items: categorys
          .map(
            (category) => SapiDropDownModel(
              displayName: category.name.sapiExt
                  .textLocale(LocalizationPathEnum.category),
              value: category.id,
            ),
          )
          .toList(),
      onSelected: (select) => product = product.copyWith(category: select),
      validator: (category) => ProductValidator.emptyValidator(
        category?.value,
        localizationKey: ProductValidationLocalizationKey.emptyProductCategory,
      ),
    );
  }

  SapiTextField _buildProductPrice() {
    return SapiTextField(
      onChanged: (price) =>
          product = product.copyWith(price: double.tryParse(price)),
      validator: (price) => ProductValidator.emptyValidator(
        price,
        localizationKey: ProductValidationLocalizationKey.emptyProductPrice,
      ),
      hintText: LocaleKeys.page_new_product_add_form_prdouct_price.tr(),
      keyboardType: TextInputType.number,
      inputFormatters: [
        DecimalInputFormatter(),
        LengthLimitingTextInputFormatter(7),
      ],
    );
  }

  SapiTextField _buildProductDesc() {
    return SapiTextField(
      onChanged: (desc) => product = product.copyWith(description: desc),
      validator: (desc) {
        return ProductValidator.emptyValidator(
          desc,
          localizationKey: ProductValidationLocalizationKey.emptyProductDesc,
        );
      },
      hintText: LocaleKeys.page_new_product_add_form_product_description.tr(),
      maxLines: 3,
      textInputAction: TextInputAction.next,
    );
  }

  SapiTextField _buildProductName() {
    return SapiTextField(
      onChanged: (productName) =>
          product = product.copyWith(productName: productName),
      validator: (product) {
        return ProductValidator.emptyValidator(
          product,
          localizationKey: ProductValidationLocalizationKey.emptyProduct,
        );
      },
      hintText: LocaleKeys.page_new_product_add_form_product_name.tr(),
      textInputAction: TextInputAction.next,
    );
  }

  ProductImage _buildImagePick() {
    return ProductImage(
      key: imageKey,
      onTap: (imageFile) =>
          product = product.copyWith(imagePath: imageFile?.path),
    );
  }
}
