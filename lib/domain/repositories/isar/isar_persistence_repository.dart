import 'package:baccus_kitchen/data/isar/isar_persisted_data.dart';
import 'package:baccus_kitchen/data/model/persisted_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_repository.dart';
import 'package:baccus_kitchen/domain/repositories/i_isar_repository.dart';
import 'package:isar/isar.dart';

/// Handles the local persistence of [IsarPersistedData] as Shared Preferences.
class IsarPersistenceRepository extends IIsarRepository implements IPersistenceRepository {
  @override
  Future<void> saveData(PersistedData data) async {
    final collection = IsarPersistedData.fromModel(data);
    await isarClient.writeTxn(() async {
      await isarClient.isarPersistedDatas.put(collection);
    });
  }

  @override
  Future<PersistedData?> getData() async {
    final data = await isarClient.isarPersistedDatas.where().findFirst();
    return data?.toModel();
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
