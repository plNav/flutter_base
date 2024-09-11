import 'package:baccus_kitchen/data/model/environment.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _dioInstance = DioClient._internal();

  final dio = Dio(BaseOptions(baseUrl: Environment.getEnvCredentials().baseUrl));

  factory DioClient() => _dioInstance;

  DioClient._internal();

  setToken(String token) => dio.options.headers['Authorization'] = 'Bearer $token';

  clearHeaders() => dio.options.headers.remove('token');
}
