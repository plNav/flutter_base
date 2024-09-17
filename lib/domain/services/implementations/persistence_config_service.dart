import '../../../data/model/persisted_config_data.dart';
import '../../repositories/abstractions/i_persistence_config_repository.dart';
import '../abstractions/i_persistence_config_service.dart';

class PersistenceConfigService implements IPersistenceConfigService {
  final IPersistenceConfigRepository _persistenceConfigRepository;

  PersistenceConfigService({required IPersistenceConfigRepository persistenceConfigRepository})
      : _persistenceConfigRepository = persistenceConfigRepository;

  @override
  Future<void> saveData(PersistedConfigData data) async {
    return await _persistenceConfigRepository.saveData(data);
  }

  @override
  Future<PersistedConfigData?> getData() async {
    return await _persistenceConfigRepository.getData();
  }

  @override
  Future<void> deleteAll() async {
    return await _persistenceConfigRepository.deleteAll();
  }
}
