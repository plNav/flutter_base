import 'package:baccus_kitchen/data/model/persisted_theme_data.dart';

abstract class IPersistenceThemeService {
  Future<void> saveData(PersistedThemeData data);

  Future<PersistedThemeData?> getData();

  Future<List<PersistedThemeData>> getAllData();

  Future<void> deleteData(int id);
}