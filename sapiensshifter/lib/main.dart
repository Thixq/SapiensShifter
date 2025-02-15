import 'package:core/core.dart';
import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/core/localization/localization.dart';
import 'package:sapiensshifter/core/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  LocalizationProvider.setInstance(EasyLocal());

  runApp(
    LanguageManager(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) => MaterialApp(
        theme: SapiensTheme.instance.lightTheme,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        home: const Thix(),
      ),
    );
  }
}

class Thix extends StatefulWidget {
  const Thix({super.key});

  @override
  State<Thix> createState() => _ThixState();
}

class _ThixState extends State<Thix> {
  late final FirebaseAuthManagar _authManagar;
  // late final FirebaseAuthUserOperation _userOperation =
  //     FirebaseAuthUserOperation.instance;

  @override
  void initState() {
    _authManagar = FirebaseAuthManagar.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: () async {
                try {
                  final asd = await GoogleSignCredential().call();
                  await _authManagar.signInWithCredential(credential: asd);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Google'),
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () async {
                try {
                  final asd = await AppleSignCredential().call();
                  await _authManagar.signInWithCredential(credential: asd);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Apple'),
            ),
          ],
        ),
      ),
    );
  }
}

class EasyLocal extends LocalizationProvider {
  @override
  String? getMessage(String key, {Map<String, String>? optionArgs}) {
    return key.tr(namedArgs: optionArgs);
  }
}
