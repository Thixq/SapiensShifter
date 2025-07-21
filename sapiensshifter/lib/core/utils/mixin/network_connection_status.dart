import 'package:http/http.dart' as http;
import 'package:sapiensshifter/core/exception/exceptions/network_disable_excepiton.dart';

mixin class NetworkConnectionStatus {
  final Uri _defaultUrl = Uri.parse('https://www.google.com');
  Future<bool> isNetworkAvailable() async {
    const timeoutSeconds = 5;
    try {
      final response = await http
          .head(_defaultUrl)
          .timeout(const Duration(seconds: timeoutSeconds));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      throw NetworkExcepiton('no_network_connection');
    }
  }
}
