import 'package:baccus_kitchen/data/model/persisted_data.dart';

abstract class IPersistenceService {
  Future<void> saveData(PersistedData data);

  Future<PersistedData?> getData();

  Future<List<PersistedData>> getAllData();

  Future<void> deleteData(int id);
}