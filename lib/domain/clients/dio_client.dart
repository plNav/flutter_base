
import 'package:dio/dio.dart';
import 'package:baccus_kitchen/env.dart';


class DioClient {
  static final DioClient _dioInstance = DioClient._internal();

  final dio = Dio(BaseOptions(baseUrl: baseUrl));


  factory DioClient() => _dioInstance;

  DioClient._internal();

  void setToken(String? token) {
    if (token == null || token.isEmpty) {
      throw Exception('EmptyTokenInSetException');
    }
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearHeaders() {
    dio.options.headers.remove('token');
  }



}
