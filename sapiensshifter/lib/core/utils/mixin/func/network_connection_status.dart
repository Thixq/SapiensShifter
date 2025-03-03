import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sapiensshifter/core/exception/network_disable_excepiton.dart';

mixin class NetworkConnectionStatus {
  final Uri _defaultUrl = Uri.parse('https://www.google.com');
  Future<bool> isNetworkAvailable() async {
    final respone = await http.get(_defaultUrl);
    if (respone.statusCode == HttpStatus.ok) {
      return true;
    }
    throw NetworkDisableExcepiton('no_network_connection');
  }
}
