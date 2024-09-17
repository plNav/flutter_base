
import '../../../data/model/persisted_theme_data.dart';

abstract class IPersistenceThemeRepository {
  Future<void> saveData(PersistedThemeData data);

  Future<PersistedThemeData?> getData();

  Future<void> deleteAll();
}