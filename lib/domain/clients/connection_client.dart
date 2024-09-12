import 'dart:io';

import 'package:baccus_kitchen/utils/console_printer.dart';

/// Singleton class to retrieve connection status [isConnected]
class ConnectionClient {
  static final instance = ConnectionClient._internal();

  ConnectionClient._internal();

  /// Returns true if connected, false otherwise
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.es');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      printC(warning, 'Unable to read connectivity from internet, $e');
      return false;
    }
  }
}
