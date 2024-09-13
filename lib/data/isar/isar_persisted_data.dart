import 'package:baccus_kitchen/data/model/persisted_data.dart';
import 'package:isar/isar.dart';

part 'isar_persisted_data.g.dart'; // Required for code generation

@Collection()
class IsarPersistedData {
  Id id = Isar.autoIncrement; // Auto increment ID

  late String username;
  late String token;
  late String locale; // 'es', 'en', 'de'
  late bool isLightMode;

  IsarPersistedData({
    required this.username,
    required this.token,
    required this.locale,
    required this.isLightMode,
  });

  factory IsarPersistedData.fromModel(PersistedData data) {
    return IsarPersistedData(
        username: data.username,
        token: data.token,
        locale: data.locale,
        isLightMode: data.isLightMode);
  }

  PersistedData toModel() {
    return PersistedData(
      username: username,
      token: token,
      locale: locale,
      isLightMode: isLightMode,
    );
  }
}
