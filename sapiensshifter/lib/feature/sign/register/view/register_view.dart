import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/utils_ui_export.dart';

part './widget/register_input_form.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.coffee_sapiens.tr()),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: context.padding.horizontalNormal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(child: SizedBox.expand()),
                const RegisterInputForm(),
                context.sized.emptySizedHeightBoxLow3x,
                FractionallySizedBox(
                  widthFactor: 1,
                  child: SapiButton(
                    buttonText: 'buttonText',
                    onPressed: () {},
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox.expand()),
                CupertinoButton(
                  onPressed: () {},
                  child: RichText(
                    text: TextSpan(
                      text: LocaleKeys.page_sign_sign_in_not_a_member.tr(),
                      style: TextStyle(
                        color: context.general.colorScheme.onPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: LocaleKeys.page_sign_sign_in_register_now.tr(),
                          style: const TextStyle(
                              color: CupertinoColors.activeBlue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
