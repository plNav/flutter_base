
import 'package:dio/dio.dart';
import '../clients/connection_client.dart';
import '../clients/dio_client.dart';

abstract class IDioRepository {
  final dioClient = DioClient();
  final connectionClient = ConnectionClient();

  IDioRepository({required this.url});

  Dio get dio => dioClient.dio;

  final String url;
}
