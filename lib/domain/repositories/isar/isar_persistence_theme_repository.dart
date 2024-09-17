import 'package:isar/isar.dart';

import '../../../data/isar/isar_theme_data.dart';
import '../../../data/model/persisted_theme_data.dart';
import '../abstractions/i_persistence_theme_repository.dart';
import '../i_isar_repository.dart';

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
    try {
      final data = await isarClient.isarThemeDatas.where().findFirst();
      return data!.toModel();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteAll() async {
    await isarClient.writeTxn(() async => await isarClient.isarThemeDatas.clear());
  }
}
