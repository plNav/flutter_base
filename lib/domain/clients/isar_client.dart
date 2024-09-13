import 'package:baccus_kitchen/data/isar/isar_persisted_data.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarClient {
  static final IsarClient _isarInstance = IsarClient._internal();
  late final Isar isar;

  factory IsarClient() => _isarInstance;

  IsarClient._internal();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [IsarPersistedDataSchema],
      directory: dir.path,
    );
  }

  Future<void> close() async {
    await isar.close();
  }
}
