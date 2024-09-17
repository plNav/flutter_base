import '../../../data/model/persisted_config_data.dart';

abstract class IPersistenceConfigService {
  /// ### Encrypts config data and stores it locally
  Future<void> saveData(PersistedConfigData data);

  /// ### Obtains and decrypts persisted local data with [id]=0
  Future<PersistedConfigData?> getData();

  /// ### Clears PersistedConfigData all registries
  Future<void> deleteAll();
}
