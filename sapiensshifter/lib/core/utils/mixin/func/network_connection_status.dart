import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sapiensshifter/core/exception/network_disable_excepiton.dart';
import 'package:sapiensshifter/core/logging/custom_logger.dart';

mixin class NetworkConnectionStatus {
  final _logger = CustomLogger('NetworkConnectionStatusLogger');
  final Uri _defaultUrl = Uri.parse('https://www.google.com');
  Future<bool> isNetworkAvailable() async {
    final respone = await http.get(_defaultUrl);
    if (respone.statusCode == HttpStatus.ok) {
      _logger.info('Network Connection Successful');
      return true;
    } else {
      _logger.warning('Network Connection Failed');
      throw NetworkDisableExcepiton('no_network_connection');
    }
  }
}
