import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/feature/firebase/firebase_auth/firebase_auth_managar.dart';
import 'package:sapiensshifter/feature/firebase/firebase_auth/firebase_auth_user_operation.dart';
import 'package:sapiensshifter/feature/firebase/firebase_auth/social_sign_credentians/google_sign_credential.dart';
import 'package:sapiensshifter/feature/localization/localization.dart';
import 'package:sapiensshifter/feature/theme/appliaction_theme.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
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
  late final FirebaseAuthUserOperation _userOperation =
      FirebaseAuthUserOperation.instance;

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
                final googleCredential = GoogleSignCredential();
                final credential = await googleCredential();
                await _authManagar.signInWithCredential(
                  credential: credential,
                );
                print(_userOperation.user.email);
              },
              child: const Text('Google'),
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Apple'),
            ),
          ],
        ),
      ),
    );
  }
}
