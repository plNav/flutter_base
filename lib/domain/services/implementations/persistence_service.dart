import 'package:baccus_kitchen/data/model/persisted_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_repository.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_persistence_service.dart';

class PersistenceService implements IPersistenceService {
  final IPersistenceRepository _persistenceRepository;

  PersistenceService({required IPersistenceRepository persistenceRepository})
      : _persistenceRepository = persistenceRepository;

  @override
  Future<void> saveData(PersistedData data) async {
    return await _persistenceRepository.saveData(data);
  }

  @override
  Future<PersistedData?> getData() async {
    return await _persistenceRepository.getData();
  }

  @override
  Future<List<PersistedData>> getAllData() async {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) async {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
}
