import 'package:baccus_kitchen/data/model/persisted_theme_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_theme_repository.dart';

class LocalPersistenceThemeRepository implements IPersistenceThemeRepository {
  @override
  Future<void> saveData(PersistedThemeData data) async {
    return;
  }

  @override
  Future<PersistedThemeData?> getData() async {
    return PersistedThemeData(themeMode: 'themeMode', locale: 'locale');
  }

  @override
  Future<List<PersistedThemeData>> getAllData() {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
}
