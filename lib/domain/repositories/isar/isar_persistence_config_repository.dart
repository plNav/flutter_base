import 'package:baccus_kitchen/data/isar/isar_config_data.dart';
import 'package:baccus_kitchen/data/model/persisted_config_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_config_repository.dart';
import 'package:baccus_kitchen/domain/repositories/i_isar_repository.dart';
import 'package:isar/isar.dart';

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
    await isarClient.writeTxn(() async {
      await isarClient.isarConfigDatas.put(collection);
    });
  }

  @override
  Future<PersistedConfigData?> getData() async {
    final data = await isarClient.isarConfigDatas.where().findFirst();
    final encryptedModel = data!.toModel();
    return encryptedModel.copyWith(
      token: cryptoClient.decode(encryptedModel.token),
      username: cryptoClient.decode(encryptedModel.username),
      password: cryptoClient.decode(encryptedModel.password),
    );
  }

  @override
  Future<List<PersistedConfigData>> getAllData() async {
    final List<IsarConfigData> data = await isarClient.isarConfigDatas.where().findAll();
    return data.map((d) => d.toModel()).toList();
  }

  @override
  Future<void> deleteData(int id) async {
    await isarClient.writeTxn(() async {
      await isarClient.isarConfigDatas.delete(id);
    });
  }
}
