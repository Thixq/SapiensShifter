import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:sapiensshifter/core/exception/exceptions/network_disable_excepiton.dart';

class ConnectivityService implements IConnectivityService {
  final Uri _defaultUrl = Uri.parse('https://www.google.com');
  @override
  Future<bool> checkNetworkConnection() async {
    const timeoutSeconds = Duration(seconds: 5);
    try {
      final response = await http.head(_defaultUrl).timeout(timeoutSeconds);
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      throw NetworkExcepiton('no_network_connection');
    }
  }
}
