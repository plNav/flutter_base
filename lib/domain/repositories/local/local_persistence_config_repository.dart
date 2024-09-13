import 'package:baccus_kitchen/data/model/persisted_config_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_config_repository.dart';

class LocalPersistenceConfigRepository implements IPersistenceConfigRepository {
  @override
  Future<void> saveData(PersistedConfigData data) async {
    return;
  }

  @override
  Future<PersistedConfigData?> getData() async {
    return PersistedConfigData(
      username: 'testusername',
      token: 'testtoken',
    );
  }

  @override
  Future<List<PersistedConfigData>> getAllData() {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
}
