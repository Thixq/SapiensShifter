import 'package:flutter/material.dart' show VoidCallback;

class SocialButtonModel {
  SocialButtonModel({required this.path, required this.onPress});

  String path;
  VoidCallback onPress;
}
