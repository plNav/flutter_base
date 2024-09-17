import '../../../data/model/persisted_config_data.dart';

abstract class IPersistenceConfigRepository {
  Future<void> saveData(PersistedConfigData data);

  Future<PersistedConfigData?> getData();

  Future<void> deleteAll();
}
