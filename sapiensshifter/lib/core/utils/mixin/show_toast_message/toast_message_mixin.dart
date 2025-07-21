import 'package:flutter/material.dart';

mixin ToastMessageMixin<T extends StatefulWidget> on State<T> {
  void showSnakeToastMessage(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
