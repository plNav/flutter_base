import 'package:baccus_kitchen/data/model/persisted_config_data.dart';
import 'package:isar/isar.dart';

part 'isar_config_data.g.dart';

@Collection()
class IsarConfigData {
  Id id = Isar.autoIncrement;

  final String token;
  final String username;

  IsarConfigData({
    required this.username,
    required this.token,
  });

  factory IsarConfigData.fromModel(PersistedConfigData data) =>
      IsarConfigData(username: data.username, token: data.token);

  PersistedConfigData toModel() => PersistedConfigData(username: username, token: token);
}
