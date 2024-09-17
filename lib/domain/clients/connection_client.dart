import 'dart:io';

import '../../data/enum/exception_type.dart';
import '../../data/model/exception_custom.dart';

/// Singleton class to retrieve connection status [validateConnection]
class ConnectionClient {
  static final _connectionInstance = ConnectionClient._internal();

  factory ConnectionClient() => _connectionInstance;

  ConnectionClient._internal();

  /// Throws a custom error if internet connection is not available
  validateConnection() async {
    try {
      final result = await InternetAddress.lookup('google.es');
      if (!(result.isNotEmpty && result[0].rawAddress.isNotEmpty)) {
        throw CustomException(type: ExceptionType.noInternet);
      }
    } on SocketException catch (e) {
      throw CustomException(type: ExceptionType.noInternet, originalException: e);
    }
  }
}
