import 'package:baccus_kitchen/data/isar/isar_persisted_data.dart';
import 'package:baccus_kitchen/data/model/persisted_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_repository.dart';
import 'package:baccus_kitchen/domain/repositories/i_isar_repository.dart';
import 'package:isar/isar.dart';

/// Handles the local persistence of [IsarPersistedData] as Shared Preferences with encryption.
class IsarPersistenceRepository extends IIsarRepository implements IPersistenceRepository {
  @override
  Future<void> saveData(PersistedData data) async {
    final encryptedData = data.copyWith(
      username: cryptoClient.encode(data.username),
      token: cryptoClient.encode(data.token),
    );
    final collection = IsarPersistedData.fromModel(encryptedData);
    await isarClient.writeTxn(() async {
      await isarClient.isarPersistedDatas.put(collection);
    });
  }

  @override
  Future<PersistedData?> getData() async {
    final data = await isarClient.isarPersistedDatas.where().findFirst();
    final encryptedModel = data!.toModel();
    return encryptedModel.copyWith(
      username: cryptoClient.decode(encryptedModel.username),
      token: cryptoClient.decode(encryptedModel.token),
    );
  }

  @override
  Future<List<PersistedData>> getAllData() async {
    final List<IsarPersistedData> data = await isarClient.isarPersistedDatas.where().findAll();
    return data.map((d) => d.toModel()).toList();
  }

  @override
  Future<void> deleteData(int id) async {
    await isarClient.writeTxn(() async {
      await isarClient.isarPersistedDatas.delete(id);
    });
  }
}
