import '../../../data/model/persisted_config_data.dart';
import '../abstractions/i_persistence_config_repository.dart';

class LocalPersistenceConfigRepository implements IPersistenceConfigRepository {
  @override
  Future<void> saveData(PersistedConfigData data) async {
    return;
  }

  @override
  Future<PersistedConfigData?> getData() async {
    return null;
  }


  @override
  Future<void> deleteAll() async {
    return;
  }
}
