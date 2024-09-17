import '../clients/crypto_client.dart';
import '../clients/isar_client.dart';

abstract class IIsarRepository {
  final isarClient = IsarClient().isar;
  final cryptoClient = CryptoClient();
}
