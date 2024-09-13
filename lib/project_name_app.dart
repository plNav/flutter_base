import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_config_repository.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_persistence_theme_repository.dart';
import 'package:baccus_kitchen/domain/repositories/dio/dio_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/isar/isar_persistence_config_repository.dart';
import 'package:baccus_kitchen/domain/repositories/isar/isar_persistence_theme_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_persistence_config_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_persistence_theme_repository.dart';
import 'package:baccus_kitchen/domain/services/implementations/persistence_theme_service.dart';
import 'package:baccus_kitchen/ui/bloc/theme/theme_bloc.dart';
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
      RepositoryProvider<IPersistenceConfigRepository>(
          create: (_) => LocalPersistenceConfigRepository()),
      RepositoryProvider<IPersistenceThemeRepository>(
          create: (_) => LocalPersistenceThemeRepository()),
    ];
    final dioRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => DioLoginRepository()),
      RepositoryProvider<IPersistenceConfigRepository>(
          create: (_) => IsarPersistenceConfigRepository()),
      RepositoryProvider<IPersistenceThemeRepository>(
          create: (_) => IsarPersistenceThemeRepository()),
    ];

    return MultiRepositoryProvider(
      providers: isTestingMode ? localRepos : dioRepos,
      // ThemeBloc is provided in app level so it will be available everywhere.
      child: BlocProvider(
        create: (context) => ThemeBloc(
          persistenceThemeService: PersistenceThemeService(
            persistenceThemeRepository: context.read<IPersistenceThemeRepository>(),
          ),
        )..add(LoadPersistedThemeEvent()),
        // Theme Bloc Builder for dynamically change schema or locale.
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) => MaterialApp(
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
            locale: themeState.locale,
            debugShowCheckedModeBanner: false,
            themeMode: themeState.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            routes: Routes.routes,
            initialRoute: login,
          ),
        ),
      ),
    );
  }
}
