import 'package:baccus_kitchen/data/model/persisted_config_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_config_repository.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_persistence_config_service.dart';

class PersistenceConfigService implements IPersistenceConfigService {
  final IPersistenceConfigRepository _persistenceConfigRepository;

  PersistenceConfigService({required IPersistenceConfigRepository persistenceRepository})
      : _persistenceConfigRepository = persistenceRepository;

  @override
  Future<void> saveData(PersistedConfigData data) async {
    return await _persistenceConfigRepository.saveData(data);
  }

  @override
  Future<PersistedConfigData?> getData() async {
    return await _persistenceConfigRepository.getData();
  }

  @override
  Future<List<PersistedConfigData>> getAllData() async {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) async {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
}
