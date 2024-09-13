import 'package:baccus_kitchen/data/model/persisted_config_data.dart';

abstract class IPersistenceConfigRepository {
  Future<void> saveData(PersistedConfigData data);

  Future<PersistedConfigData?> getData();

  Future<List<PersistedConfigData>> getAllData();

  Future<void> deleteData(int id);
}