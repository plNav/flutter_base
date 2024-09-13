import 'package:baccus_kitchen/domain/clients/connection_client.dart';
import 'package:baccus_kitchen/domain/clients/dio_client.dart';
import 'package:dio/dio.dart';

abstract class IDioRepository {
  final dioClient = DioClient();
  final connectionClient = ConnectionClient();

  IDioRepository({required this.url});

  Dio get dio => dioClient.dio;

  final String url;
}
