import 'package:dio/dio.dart';

import '../../data/model/environment.dart';

/// Singleton class for managing Dio HTTP client configurations.
///
/// The DioClient should be used at the **repository level** for making HTTP requests.
/// The base URL is dynamically loaded from the environment configuration.
class DioClient {
  static final DioClient _dioInstance = DioClient._internal();

  final dio = Dio(BaseOptions(baseUrl: Environment.getEnvCredentials().baseUrl));

  factory DioClient() => _dioInstance;

  DioClient._internal();

  /// Sets the authentication token in the Dio headers for secured requests.
  setToken(String token) => dio.options.headers['Authorization'] = 'Bearer $token';

  /// Clears the authentication token from the Dio headers. **Call it on Logout**
  clearHeaders() => dio.options.headers.remove('Authorization');
}
