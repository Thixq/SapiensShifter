import 'package:flutter_test/flutter_test.dart';
import 'package:sapiensshifter/product/utils/func/network_connection_status.dart';

void main() {
  test(
    'Network Connection',
    () async {
      final connectionStatus =
          await NetworkConnectionStatus.isNetworkAvailable();
      expect(connectionStatus, true);
    },
  );
}
