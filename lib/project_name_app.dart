import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_repository.dart';
import 'package:baccus_kitchen/domain/repositories/dio/dio_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/isar/isar_persistence_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_persistence_repository.dart';
import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:baccus_kitchen/ui/navigation/routes.dart';
import 'package:baccus_kitchen/ui/theme/schema/dark/dark_theme.dart';
import 'package:baccus_kitchen/ui/theme/schema/light/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ProjectNameApp extends StatelessWidget {
  const ProjectNameApp({super.key, required this.isTestingMode});

  /// - ## true  : Local Repos
  /// - ## false : Dio & Isar Repos
  final bool isTestingMode;

  @override
  Widget build(BuildContext context) {
    final localRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => LocalLoginRepository()),
      RepositoryProvider<IPersistenceRepository>(create: (_) => LocalPersistenceRepository()),
    ];
    final dioRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => DioLoginRepository()),
      RepositoryProvider<IPersistenceRepository>(create: (_) => IsarPersistenceRepository()),
    ];

    return MultiRepositoryProvider(
      providers: isTestingMode ? localRepos : dioRepos,
      child: MaterialApp(
        title: 'Project Name',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('de'), // German
          Locale('es'), // Spanish
        ],
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: Routes.routes,
        initialRoute: login,
      ),
    );
  }
}
