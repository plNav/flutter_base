import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/isar/isar_config_data.dart';
import '../../data/isar/isar_theme_data.dart';

/// Singleton class for managing Isar database. Use it at repository level.
///
/// The [init] method requires schemas to be included, generated using:
/// - `dart run build_runner build`.
class IsarClient {
  static final IsarClient _isarInstance = IsarClient._internal();

  late final Isar isar;

  factory IsarClient() => _isarInstance;

  IsarClient._internal();

  /// Initializes the Isar database by loading schemas and opening the connection.
  /// Ensure you include the generated schemas after running the build runner.
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [IsarConfigDataSchema, IsarThemeDataSchema], // Add new schemas here
      directory: dir.path,
    );
  }

  Future<void> close() async => await isar.close();
}
