import 'package:baccus_kitchen/domain/clients/crypto_client.dart';
import 'package:baccus_kitchen/domain/clients/isar_client.dart';

abstract class IIsarRepository {
  final isarClient = IsarClient().isar;
  final cryptoClient = CryptoClient();
}
