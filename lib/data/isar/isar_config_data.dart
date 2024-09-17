import '../model/persisted_config_data.dart';
import 'package:isar/isar.dart';

part 'isar_config_data.g.dart';

@Collection()
class IsarConfigData {
  //Id id = Isar.autoIncrement;
  final Id id = 0;

  final String token;
  final String username;
  final String password;

  IsarConfigData({
    required this.token,
    required this.username,
    required this.password,
  });

  factory IsarConfigData.fromModel(PersistedConfigData data) =>
      IsarConfigData(token: data.token, username: data.username, password: data.password);

  PersistedConfigData toModel() => PersistedConfigData(token: token, username: username, password: password);
}
