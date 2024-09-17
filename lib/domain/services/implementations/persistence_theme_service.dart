import '../../../data/model/persisted_theme_data.dart';
import '../../repositories/abstractions/i_persistence_theme_repository.dart';
import '../abstractions/i_persistence_theme_service.dart';

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
  Future<void> deleteAll() async {
    return await _persistenceThemeRepository.deleteAll();
  }
}
