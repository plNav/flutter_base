import 'package:baccus_kitchen/data/isar/isar_config_data.dart';
import 'package:baccus_kitchen/data/isar/isar_theme_data.dart';
import 'package:baccus_kitchen/data/model/persisted_config_data.dart';
import 'package:baccus_kitchen/data/model/persisted_theme_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_config_repository.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_theme_repository.dart';
import 'package:baccus_kitchen/domain/repositories/i_isar_repository.dart';
import 'package:isar/isar.dart';

/// Handles the local persistence of [IsarConfigData] as Shared Preferences with encryption.
class IsarPersistenceThemeRepository extends IIsarRepository
    implements IPersistenceThemeRepository {
  @override
  Future<void> saveData(PersistedThemeData data) async {
    final collection = IsarThemeData.fromModel(data);
    await isarClient.writeTxn(() async {
      await isarClient.isarThemeDatas.put(collection);
    });
  }

  @override
  Future<PersistedThemeData?> getData() async {
    final data = await isarClient.isarThemeDatas.where().findFirst();
    return data!.toModel();
  }

  @override
  Future<List<PersistedThemeData>> getAllData() async {
    final List<IsarThemeData> data = await isarClient.isarThemeDatas.where().findAll();
    return data.map((d) => d.toModel()).toList();
  }

  @override
  Future<void> deleteData(int id) async {
    await isarClient.writeTxn(() async {
      await isarClient.isarThemeDatas.delete(id);
    });
  }
}
