import '../../../data/model/persisted_theme_data.dart';
import '../abstractions/i_persistence_theme_repository.dart';

class LocalPersistenceThemeRepository implements IPersistenceThemeRepository {
  @override
  Future<void> saveData(PersistedThemeData data) async {
    return;
  }

  @override
  Future<PersistedThemeData?> getData() async {
    return null;
  }

  @override
  Future<void> deleteAll() async {
    return;
  }
}
