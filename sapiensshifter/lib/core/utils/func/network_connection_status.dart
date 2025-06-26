import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sapiensshifter/core/exception/exceptions/network_disable_excepiton.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/ui_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';

mixin class NetworkConnectionStatus {
  final Uri _defaultUrl = Uri.parse('https://www.google.com');
  Future<bool> isNetworkAvailable(BuildContext context) async {
    const timeoutSeconds = 5;
    return ErrorUtil.runWithErrorHandlingAsync<bool>(
      action: () async {
        final response = await http
            .head(_defaultUrl)
            .timeout(const Duration(seconds: timeoutSeconds));
        return response.statusCode >= 200 && response.statusCode < 300;
      },
      errorMapper: (error, [stackTrace]) =>
          NetworkExcepiton('no_network_connection', stackTrace: stackTrace),
      errorHandler: UIErrorHandler(context),
      fallbackValue: () async => false,
    );
  }
}
