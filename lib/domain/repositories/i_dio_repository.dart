import 'package:baccus_kitchen/domain/clients/dio_client.dart';
import 'package:dio/dio.dart';

abstract class IDioRepository {
  final dioClient = DioClient();

  IDioRepository({required this.url});

  Dio get dio => dioClient.dio;

  final String url;
}
