import 'package:baccus_kitchen/data/model/persisted_theme_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_theme_repository.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_persistence_theme_service.dart';

class PersistenceThemeService implements IPersistenceThemeService {
  final IPersistenceThemeRepository _persistenceThemeRepository;

  PersistenceThemeService({required IPersistenceThemeRepository persistenceThemeRepository})
      : _persistenceThemeRepository = persistenceThemeRepository;

  @override
  Future<void> saveData(PersistedThemeData data) async {
    return await _persistenceThemeRepository.saveData(data);
  }

  @override
  Future<PersistedThemeData?> getData() async {
    return await _persistenceThemeRepository.getData();
  }

  @override
  Future<List<PersistedThemeData>> getAllData() async {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) async {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
}
