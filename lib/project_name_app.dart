import 'package:baccus_kitchen/data/model/environment.dart';
import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/clients/crypto_client.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/dio/dio_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/local/local_login_repository.dart';
import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:baccus_kitchen/ui/navigation/routes.dart';
import 'package:baccus_kitchen/ui/theme/schema/dark/dark_theme.dart';
import 'package:baccus_kitchen/ui/theme/schema/light/light_theme.dart';
import 'package:baccus_kitchen/utils/console_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ProjectNameApp extends StatelessWidget {
  const ProjectNameApp({super.key, required this.isLocalMode});

  /// ## true->LocalRepos  false->DioRepos
  final bool isLocalMode;

  @override
  Widget build(BuildContext context) {
    const user = User(id: 'id', name: 'name');
    printC(yellow, user.toString());

    final env = Environment.getEnvCredentials();
    printC(yellow, env.baseUrl);
    printC(yellow, env.secretKey);
    final encrypted = CryptoClient().encode(env.baseUrl);
    final decrypted = CryptoClient().decode(encrypted);
    printC(green, 'CryptoClient $decrypted');

    final localRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => LocalLoginRepository()),
    ];
    final dioRepos = [
      RepositoryProvider<ILoginRepository>(create: (_) => DioLoginRepository()),
    ];

    return MultiRepositoryProvider(
      providers: isLocalMode ? localRepos : dioRepos,
      child: MaterialApp(
        title: 'Project Name',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
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
