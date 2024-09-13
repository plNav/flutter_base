import 'package:baccus_kitchen/data/model/persisted_data.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_repository.dart';

class LocalPersistenceRepository implements IPersistenceRepository {
  @override
  Future<void> saveData(PersistedData data) async {
    return;
  }

  @override
  Future<PersistedData?> getData() async {
    return PersistedData(
      username: 'testusername',
      token: 'testtoken',
      locale: 'es',
      isLightMode: false,
    );
  }

  @override
  Future<List<PersistedData>> getAllData() {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }
}
