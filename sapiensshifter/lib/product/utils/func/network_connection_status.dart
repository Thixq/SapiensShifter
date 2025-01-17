import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkConnectionStatus {
  static final Uri _defaultUrl = Uri.parse('https://www.google.com');
  static Future<bool> isNetworkAvailable() async {
    final respone = await http.get(_defaultUrl);
    if (respone.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }
}
