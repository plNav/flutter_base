import 'package:isar/isar.dart';

import '../../../data/isar/isar_config_data.dart';
import '../../../data/model/persisted_config_data.dart';
import '../abstractions/i_persistence_config_repository.dart';
import '../i_isar_repository.dart';

/// Handles the local persistence of [IsarConfigData] as Shared Preferences with encryption.
class IsarPersistenceConfigRepository extends IIsarRepository
    implements IPersistenceConfigRepository {
  @override
  Future<void> saveData(PersistedConfigData data) async {
    final encryptedData = data.copyWith(
      token: cryptoClient.encode(data.token),
      username: cryptoClient.encode(data.username),
      password: cryptoClient.encode(data.password),
    );
    final collection = IsarConfigData.fromModel(encryptedData);
    await isarClient.writeTxn(() async => await isarClient.isarConfigDatas.put(collection));
  }

  @override
  Future<PersistedConfigData?> getData() async {
    try {
      final data = await isarClient.isarConfigDatas.where().findFirst();
      final encryptedModel = data!.toModel();
      return encryptedModel.copyWith(
        token: cryptoClient.decode(encryptedModel.token),
        username: cryptoClient.decode(encryptedModel.username),
        password: cryptoClient.decode(encryptedModel.password),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteAll() async {
    await isarClient.writeTxn(() async => await isarClient.isarConfigDatas.clear());
  }
}
