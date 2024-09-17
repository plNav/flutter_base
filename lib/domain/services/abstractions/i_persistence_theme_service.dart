import '../../../data/model/persisted_theme_data.dart';

abstract class IPersistenceThemeService {

  /// ### Stores theme data locally.
  Future<void> saveData(PersistedThemeData data);

  /// ### Obtains stored data with [id]=0
  Future<PersistedThemeData?> getData();

  /// ### Clears PersistedThemeData all registries
  Future<void> deleteAll();
}