import 'package:baccus_kitchen/data/model/persisted_theme_data.dart';
import 'package:isar/isar.dart';

part 'isar_theme_data.g.dart';

@Collection()
class IsarThemeData {
  Id id = Isar.autoIncrement;

  final String themeMode;
  final String locale;

  IsarThemeData({required this.themeMode, required this.locale});

  factory IsarThemeData.fromModel(PersistedThemeData data) =>
      IsarThemeData(themeMode: data.themeMode, locale: data.locale);

  PersistedThemeData toModel() => PersistedThemeData(themeMode: themeMode, locale: locale);
}
